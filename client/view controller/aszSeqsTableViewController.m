//
//  aszSeqsTableViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqsTableViewController.h"
#import "aszSeqsTableCell.h"
#import "aszJsonDictionarryManip.h"
@interface aszSeqsTableViewController ()

@property (nonatomic,strong) NSArray *los;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


@end

@implementation aszSeqsTableViewController

@synthesize data=_data;
@synthesize webdl=_webdl;
@synthesize los=_los;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [self.tableView registerClass:[ aszSeqsTableCell class] forCellReuseIdentifier:@"cell"];

    self.los = [self.data valueForKey:@"learningObjects"];

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
    
    
    
    
    
    //
    //learningObjects: [
    //                  {
    //                  cid:
    //                  title:   //optional
    //
    //                  sequences: [
    //                              {
    //                              cid:
    //                              title:
    //                              contentUrl:
    //                              thumbnailUrl:
    //
    //                              },...]
    //
    //
    //                  },...]
    //
    //
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
  
    
  //  NSString *ff = [aszJsonDictionarryManip dictionarryToPrintableString:[self.los objectAtIndex:section]];

    
    
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







