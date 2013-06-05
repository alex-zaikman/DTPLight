//
//  aszClassesViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/3/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszClassesViewController.h"
#import "aszClassesViewCell.h"
#import "aszCourseContentData.h"


@interface aszClassesViewController ()

@property (nonatomic,strong) NSDictionary *dataToPass;
@end

@implementation aszClassesViewController

@synthesize data=_data;
@synthesize dataToPass=_dataToPass;


-(void)viewDidLoad{
    [self.collectionView registerClass:[aszClassesViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    NSInteger i =[(NSArray*)[self.data valueForKey:@"classes"]count];
   return i;
}

// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    aszClassesViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *url = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"classImageUrl"];
    
    url = [[[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"]  stringByAppendingString:url];
    
    
    
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    UIImage *img = [UIImage imageWithData:bgImageData];
    
    [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:237/255.0f blue:108/255.0f alpha:1.0f]];
    
    
    [cell setBackgroundView:[[UIImageView alloc]initWithImage:img]];
    
    NSString *className = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"className"];
    
    cell.lable.text = className;
    
    NSArray *classes = (NSArray*)[self.data valueForKey:@"classes"];
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    NSDictionary *class = [classes objectAtIndex:index];
    NSNumber *cid = [class valueForKey:@"classId"];
    
    
    cell.tag =[cid integerValue] ;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *currentCell = [collectionView cellForItemAtIndexPath:indexPath];
    

    NSNumber *cid = [[NSNumber alloc] initWithInt: currentCell.tag];
    

    aszCourseContentData* cd = [[aszCourseContentData alloc]init];
    
     NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
    
    [cd getDataQueryDomain:domain forClassId:[cid integerValue] OnSuccessCall:^(NSDictionary * ddata) {

        self.dataToPass=ddata;
       //  [self performSegueWithIdentifier:@"coursemaster" sender:self];
         [self performSegueWithIdentifier:@"coursedetail" sender:self];
        
    } onFailureCall:^(NSError *e) {
    
    }];
    
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if([[segue identifier] isEqualToString:@"coursemaster"]){
//        [segue.destinationViewController performSelector:@selector(setData:)
//                                              withObject:self.dataToPass];
//        
//    }else
        if([[segue identifier] isEqualToString:@"coursedetail"] ){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.dataToPass];
        
    }
}

@end