//
//  aszCourseOverviewDetailViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/3/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszCourseOverviewDetailViewController.h"
#import "aszJsonDictionarryManip.h"
#import "aszLessonSequensesData.h"


@interface aszCourseOverviewDetailViewController () 

+(NSArray*) prepareTocToPopulate:(NSDictionary*) toc identBy:(NSNumber*) i;

@property (nonatomic,strong) NSArray *tocData;
@property (nonatomic,strong) NSDictionary* dataToPass;
@property (nonatomic,weak) UIViewController *webdl;

@end

@implementation aszCourseOverviewDetailViewController

@synthesize data=_data;
@synthesize tocData=_tocData;
@synthesize dataToPass=_dataToPass;
@synthesize webdl=_webdl;

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *toc=[self.data valueForKey:@"toc"];
    
    if(!self.tocData)
        self.tocData = [aszCourseOverviewDetailViewController prepareTocToPopulate:toc identBy:@(1)];
    
    return [self.tocData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    
    NSMutableString *out = [[NSMutableString alloc]init];
    
    int i = [[[self.tocData objectAtIndex:index] valueForKey:@"ident"] intValue];
    
    CGFloat f= i;
    
    while(i > 0 ){
         i--;
        [out appendString:@"        "];
    }
    
    [out appendString:[[self.tocData objectAtIndex:index] valueForKey:@"title"]];
    
    cell.textLabel.text = out;

   
    f = cell.textLabel.font.pointSize*1.3 - f*2.5;
   
    int ci=10*(f+1);
    
    CGFloat hue = ( ci % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( ci % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( ci % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *base = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    cell.textLabel.font =  [cell.textLabel.font fontWithSize:f];
    
    cell.textLabel.textColor = base;
    
    cell.tag = index;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    
    NSDictionary *pressed = [self.tocData objectAtIndex:index];
    
    //if chapter show overview
    if([[pressed valueForKey:@"innerType"] isEqualToString:@"tocItem"]){
        
        //segue to @"chapterOverview" with pressed valueForKey:@"overview"]
        self.dataToPass = [[NSMutableDictionary alloc]init];
        
        [self.dataToPass setValue:[pressed valueForKey:@"title"]  forKey:@"title"];
        
        [self.dataToPass setValue:[pressed valueForKey:@"overview"]  forKey:@"overview"];
        
        [self performSegueWithIdentifier:@"chapterOverview" sender:self];
        
        
        
    }else{ //go into lesson
    
    
    self.dataToPass = [[NSMutableDictionary alloc]init];

           NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
        
       
        
        aszLessonSequensesData *lsq = [[aszLessonSequensesData alloc]init];
        
        [lsq getDataQueryDomain:domain
                    withClassId:[self.data valueForKey:@"classId"] 
                   withCourseId:[[self.data valueForKey:@"book"] valueForKey:@"courseId"]
                    andLessonId: [pressed valueForKey:@"cid"]
                 andLessonTitle: [pressed valueForKey:@"title"]
                  OnSuccessCall:^(NSDictionary * datatopass) {
            
            self.dataToPass=datatopass;
             
            [self performSegueWithIdentifier:@"webdl" sender:self];

            [self performSegueWithIdentifier:@"seqs" sender:self];
                                 

        } onFailureCall:^(NSError *e) {
            //do nothing
        }];
    
    }
}




+(NSArray*) prepareTocToPopulate:(NSDictionary*) toc  identBy:(NSNumber*) i{
    
    NSMutableArray *retArr=[[NSMutableArray alloc]init];

    if([toc valueForKey:@"lessons"]){
        
        for(NSDictionary *lesson in [toc valueForKey:@"lessons"]){
           
            NSMutableDictionary *mlesson = [lesson mutableCopy];
            [mlesson setValue:i forKey:@"ident"];
            [mlesson setValue:@"lesson" forKey:@"innerType"];
            [retArr addObject:[mlesson copy]];
        }
    }
    
    if([toc valueForKey:@"tocItems"]){
        for(NSDictionary *tocItem in [toc valueForKey:@"tocItems"]){
            
            NSMutableDictionary *mtocitem = [tocItem mutableCopy];
            [mtocitem setValue:@"tocItem" forKey:@"innerType"];
            [mtocitem setValue:i forKey:@"ident"];
            [retArr addObject:[mtocitem copy]];
            
            [retArr addObjectsFromArray:[aszCourseOverviewDetailViewController prepareTocToPopulate:tocItem identBy:@([i intValue ]+1)]];
            
        }
    }
    
    return [retArr copy];
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  

    
    
    if([[segue identifier] isEqualToString:@"chapterOverview"]){
        [segue.destinationViewController performSelector:@selector(set:)
                                              withObject:self.dataToPass];
        
    }
    else if([[segue identifier] isEqualToString:@"seqs"] ){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.dataToPass];
        [segue.destinationViewController performSelector:@selector(setWebdl:)
                                              withObject:self.webdl];
        
    }
    else if([[segue identifier] isEqualToString:@"webdl"] ){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.dataToPass];
        self.webdl = segue.destinationViewController;
    }
}



@end
