//
//  aszSeqsTableViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqsTableViewController.h"
#import "aszSeqsTableCell.h"
#import "aszHttpConnectionHandler.h"
#import "aszJsonDictionarryManip.h"
#import "aszWebDlViewController.h"
#import "aszUIWebViewDelegate.h"


@interface aszSeqsTableViewController () 

@property (nonatomic,strong) NSArray *los;

@property (nonatomic,strong) NSMutableDictionary *cells;


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


- (UITableViewCell *)cachedTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSArray *dlData;
@property (nonatomic,strong) NSMutableDictionary *dlRequests;


+(NSMutableDictionary*)dataForPageing:(NSDictionary*)data;

@end

@implementation aszSeqsTableViewController

@synthesize cells=_cells;
@synthesize data=_data;
@synthesize webdl=_webdl;
@synthesize los=_los;





- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self.navigationItem setHidesBackButton:YES];
    
    }
    return self;
}

+(NSMutableDictionary*)dataForPageing:(NSDictionary*)data{
    
    NSDictionary *los = [data valueForKey:@"learningObjects"];
    
    
    NSString *courseId = [[data valueForKey:@"book"] valueForKey:@"courseCid"];
    NSString *role = [[data valueForKey:@"user"] valueForKey:@"role"];
    
    NSMutableDictionary *dlRequests= [[NSMutableDictionary alloc]init];
    
    int acumulatedIndex=0;
    
    for(NSDictionary * lorningObj in los) //for each lorningObj in lorningObjs
    {
        
        for(NSDictionary * seq in [lorningObj valueForKey:@"sequences"]) {//for each seq under the lo
            
            
            NSDictionary __block *currentSeq = @{
                                                 @"acumulatedIndex": @(acumulatedIndex),
                                                 @"courseId": courseId ,
                                                 @"role":role,
                                                 @"loTitle": [seq valueForKey:@"title"] ,
                                                 @"seqTitle": [seq valueForKey:@"title"] ,
                                                 @"thumbnailUrl":[seq valueForKey:@"thumbnailUrl"],
                                                 @"contentUrl":[seq valueForKey:@"contentUrl"]
                                                };
            acumulatedIndex++;
            
            NSString __block *jsonUrl =  [currentSeq valueForKey:@"contentUrl"];
            
            aszHttpConnectionHandler *connection = [[aszHttpConnectionHandler alloc]init];
            
            NSURLRequest *request1 = [aszHttpConnectionHandler requestWithUrl:jsonUrl usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
            
            [connection execRequest:request1 OnSuccessCall:^(NSData *data) {
                
                
                ///player data
                NSString *jsonDataString = [[NSString alloc] initWithData:data
                                                                 encoding:NSUTF8StringEncoding];
                
                
                //html addres
                NSString *urlAddress = @"http://cto.timetoknow.com/cms/player/dl/index2.html";
                
                
                //media url
                NSMutableString *mediaUrl=[[NSMutableString alloc]init];
                
                [mediaUrl appendString: @"\"/cms/courses/"];
                
                [mediaUrl appendString: [currentSeq valueForKey:@"courseId"]];
                
                [mediaUrl appendString: @"\""];
                
                //init data
                NSMutableString *initData=[[NSMutableString alloc]init];
                
                [initData appendString:@"{ width: 1024, height: 600, scale: 1, basePaths: { player:"];
                
                //this.playerPath
                [initData appendString: @"\"http://cto.timetoknow.com/cms/player/dl\""];
                
                
                [initData appendString: @", media:"];
                
                [initData appendString: mediaUrl];
                
                [initData appendString: @"}, complay:true, localeName:\"en_US\",   apiVersion: '1.0',  loId: 'inst_s', isLoggingEnabled: true, userInfo : { role: '"];
                
                [initData appendString:@"student"];//[initData appendString:role];
                
                [initData appendString:  @"' }   }"];
                
                NSURLRequest *request2 = [aszHttpConnectionHandler requestWithUrl:urlAddress usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
                
                aszUIWebViewDelegate *delegate = [[aszUIWebViewDelegate alloc]initWtihData:@[initData  ,jsonDataString ]];
                
                [dlRequests setObject:@[request2,  delegate  ] forKey:[currentSeq valueForKey:@"acumulatedIndex"]];
                
            } onFailureCall:^(NSError *e) {
                //wish i could help
            }];
            
        }
        
    }
    
    return dlRequests;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.modalInPopover=YES;

    self.los = [self.data valueForKey:@"learningObjects"];

  
    /////////////////////////////////////prep data////////////////////////////////////////////////////////
    
    
     NSString *courseId = [[self.data valueForKey:@"book"] valueForKey:@"courseCid"];
     NSString *role = [[self.data valueForKey:@"user"] valueForKey:@"role"];
     self.dlRequests= [[NSMutableDictionary alloc]init];
    
    int acumulatedIndex = 0;
    
    NSMutableArray *sections = [[NSMutableArray alloc]initWithCapacity:[self.los count]];
    
    for(NSDictionary * lorningObj in self.los) //for each lorningObj in lorningObjs
    {
       
        NSMutableArray *rows = [[NSMutableArray alloc]init];
        
        for(NSDictionary * seq in [lorningObj valueForKey:@"sequences"]) {//for each seq under the lo
        
            
            [rows addObject: @{
             
             @"acumulatedIndex":[NSNumber numberWithInt:acumulatedIndex],
             
             @"courseId": courseId ,
             @"role":role,
             
             @"loTitle": [seq valueForKey:@"title"] ,
            
             @"seqTitle": [seq valueForKey:@"title"] ,
             @"thumbnailUrl":[seq valueForKey:@"thumbnailUrl"],
             @"contentUrl":[seq valueForKey:@"contentUrl"]
             
             }];
             acumulatedIndex++;
                      
        }
        
        [sections addObject:rows];
        
    }
    
    self.dlData =[sections copy];

    
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    self.dlRequests =[aszSeqsTableViewController dataForPageing:self.data];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dlData count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dlData objectAtIndex:section] count];
}


- (UITableViewCell *)cachedTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!self.cells)
        self.cells = [[NSMutableDictionary alloc]init];
    
       
    int ikey = indexPath.section*1000 +  indexPath.row;
    NSString *key=[NSString stringWithFormat:@"%d", ikey];
    
    if(![self.cells valueForKey:key]){
    
    
        static NSString *CellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        NSDictionary *seq = [[self.dlData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]  ;
    
        cell.textLabel.text= [seq valueForKey:@"seqTitle"];
    
        cell.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
    
        NSString *url = [seq valueForKey:@"thumbnailUrl"];
        NSURL *bgImageURL = [NSURL URLWithString:url];
        NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    
        cell.imageView.image =     [ [self class]  imageWithImage:[UIImage imageWithData:bgImageData] scaledToSize:CGSizeMake(300,200)] ;
    
        cell.tag = ikey;
    
    [self.cells setValue:cell  forKey:key];
        
    return cell;
        
    }
    else{
     return [self.cells valueForKey:key];   
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self cachedTableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return cell;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSNumber *acuIndex =  [[[self.dlData objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] valueForKey:@"acumulatedIndex"];
    
    NSURLRequest *req=[self.dlRequests  objectForKey:acuIndex][0];

    
    ((aszWebDlViewController *)self.webdl).dlWebView.delegate = [self.dlRequests  objectForKey:acuIndex][1];
    
    [((aszWebDlViewController *)self.webdl).dlWebView  loadRequest:req ];
    
    
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    
    NSString *headerTitle;
    
    headerTitle = (NSString*)[[self.dlData objectAtIndex:section][0]  valueForKey:@"loTitle"];
    if(!headerTitle)
       headerTitle =@"lo";
    
    return headerTitle;
}



+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (IBAction)openAsPageView:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"segPageView" sender:self ];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
if([[segue identifier] isEqualToString:@"segPageView"]){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:[self.dlRequests copy]];
        
        
        NSIndexPath *path = [(UITableView*)self.view indexPathForSelectedRow];
        
        NSInteger rowNumber = 0;
        
        for (NSInteger i = 0; i < path.section; i++) {
            rowNumber += [(UITableView*)self.view numberOfRowsInSection:i];
        }
        
        rowNumber += path.row;
        
        
        
        [segue.destinationViewController performSelector:@selector(setStartIndex:)
                                              withObject:[NSNumber numberWithInt:rowNumber]];
        

        
    }
    
}

@end







