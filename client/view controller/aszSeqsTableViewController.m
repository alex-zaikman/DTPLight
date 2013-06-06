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

@interface aszSeqsTableViewController ()

@property (nonatomic,strong) NSArray *los;

@property (nonatomic,strong) NSMutableArray *dlDataUrl;
@property (nonatomic,assign) int dlcount;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


@end

@implementation aszSeqsTableViewController

@synthesize data=_data;
@synthesize webdl=_webdl;
@synthesize los=_los;
@synthesize dlDataUrl=_dlDataUrl;


- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self.navigationItem setHidesBackButton:YES];
        
        
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [self.tableView registerClass:[ aszSeqsTableCell class] forCellReuseIdentifier:@"cell"];

    self.dlDataUrl = [[NSMutableArray alloc]init];
    self.los = [self.data valueForKey:@"learningObjects"];
    self.dlcount=0;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.los count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[[self.los objectAtIndex:section] valueForKey:@"sequences"]count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *seqs = [[self.los objectAtIndex:indexPath.section] valueForKey:@"sequences"];
    int row = [indexPath indexAtPosition:[indexPath length]-1 ];
    NSDictionary *seq = [seqs objectAtIndex:row];
    
    
    
    
    cell.textLabel.text= [seq valueForKey:@"title"];
    
    cell.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSString *url = [seq valueForKey:@"thumbnailUrl"];
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    
    cell.imageView.image =     [ [self class]  imageWithImage:[UIImage imageWithData:bgImageData] scaledToSize:CGSizeMake(300,200)] ;
    
    
    NSString *jsonUrl = [seq valueForKey:@"contentUrl"];
    
    aszHttpConnectionHandler *connection = [[aszHttpConnectionHandler alloc]init];
    
    NSURLRequest *request = [aszHttpConnectionHandler requestWithUrl:jsonUrl usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
    
    [connection execRequest:request OnSuccessCall:^(NSData *data) {
    
        
        [self.dlDataUrl addObject:data];
        
        
    } onFailureCall:^(NSError *e) {
        //wish i could help
    }];
    
    cell.tag = self.dlcount;
    
    self.dlcount++;
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#warning todo
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSData *jsonData =[self.dlDataUrl objectAtIndex:cell.tag];

    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData
                                                                        encoding:NSUTF8StringEncoding];
    
    aszWebDlViewController *wdl =(aszWebDlViewController *)self.webdl;
    

    NSString *urlAddress = @"https://cto.timetoknow.com/cms/player/dl/index2.jsp";
    
    jsonDataString = [@"q=" stringByAppendingString:jsonDataString];
    
    NSURLRequest *request = [aszHttpConnectionHandler requestWithUrl:urlAddress usingMethod:@"POST" withUrlParams:nil andBodyData:jsonDataString];
    
    
    //Load the request in the UIWebView.
    [wdl.dlWebView  loadRequest:request];
    
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    
    NSString *headerTitle;
    
    headerTitle = (NSString*)[[self.los objectAtIndex:section]  valueForKey:@"title"];
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




@end







