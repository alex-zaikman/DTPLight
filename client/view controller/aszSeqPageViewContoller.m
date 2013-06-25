//
//  aszSeqPageViewContoller.m
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqPageViewContoller.h"
#import "aszSeqWebPageViewController.h"

@interface aszSeqPageViewContoller()

@property (nonatomic,strong) NSMutableDictionary *cash;
@end


@implementation aszSeqPageViewContoller

@synthesize cash=_cash;

- (void)viewDidLoad
{
    self.delegate=self;
    self.dataSource=self;

    UIViewController *startingViewController = [self viewControllerAtIndex:[self.startIndex integerValue] storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
   
}


- (aszSeqWebPageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    if(!self.cash)
        self.cash=[[NSMutableDictionary alloc]init];
    
    
    aszSeqWebPageViewController *ret;
    
    //3-way cash
    if(!(ret = [self.cash objectForKey:@(index)])){

        [self.cash removeAllObjects];
        
        int min = MAX((int)index-1,0);
        int max= MIN(index+1 , (int)[self.data count]-1);
        
        for(int i =min ;i<=max ;i++){
            
        ret = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
    
        ret.index=i;
    
        NSArray *req=[self.data objectForKey:@(i)];
    
        ret.req=req;
        
        [ret startLoading];
            
        [self.cash setObject:ret forKey:@(i)];
            
        }
        
        ret = [self.cash objectForKey:@(index)];
        
    }else{
    
        if([self.cash objectForKey:@(index+2)]!=nil){
            
           // add i-1
            aszSeqWebPageViewController  *i1 = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
            
            i1.index=index-1;
            
            i1.req=[self.data objectForKey:@(index-1)];;
         
            [i1 startLoading];
            
            [self.cash setObject:i1 forKey:@(index-1)];
         
            // remouve i+2
            i1 = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
            
            i1.index=index+2;
            
            i1.req=[self.data objectForKey:@(index+2)];
            
            [i1 startLoading];
            
            [self.cash setObject:i1 forKey:@(index+2)];
        }
        else if([self.cash objectForKey:@(index-2)]!=nil){
       
            
            // add i+1
            aszSeqWebPageViewController  *i1 = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
            
            i1.index=index+1;
            
            i1.req=[self.data objectForKey:@(index+1)];;
            
            [i1 startLoading];
            
            [self.cash setObject:i1 forKey:@(index+1)];
            
            // remouve i-2
            i1 = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
            
            i1.index=index-2;
            
            i1.req=[self.data objectForKey:@(index-2)];
            
            [i1 startLoading];
            
            [self.cash setObject:i1 forKey:@(index-2)];
        
        }
        //else clear in the middle or just too few  objs
    }
    
    return ret;
}

- (NSUInteger)indexOfViewController:(aszSeqWebPageViewController *)viewController
{
    return viewController.index;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    int index = ((aszSeqWebPageViewController*)viewController).index;
    
    if(index==0)
        return nil;
    else{
        return [self viewControllerAtIndex:(index-1) storyboard:self.storyboard];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    int index = ((aszSeqWebPageViewController*)viewController).index;
    
    if(index== [self.data count]-1)
        return nil;
    else{
       return [self viewControllerAtIndex:(index+1) storyboard:self.storyboard];
        
    }
}


#pragma mark - UIPageViewController delegate methods

-(UIPageViewControllerSpineLocation) pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
//    UIViewController *currentViewController = self.viewControllers[0];
//    NSArray *viewControllers = @[currentViewController];
//    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];

    self.doubleSided = NO;
    
    return UIPageViewControllerSpineLocationMin;
    
}


@end
