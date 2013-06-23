//
//  aszSeqPageViewContoller.m
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqPageViewContoller.h"
#import "aszSeqWebPageViewController.h"

@implementation aszSeqPageViewContoller

- (void)viewDidLoad
{
    self.delegate=self;
    self.dataSource=self;

    UIViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
}


- (aszSeqWebPageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    aszSeqWebPageViewController *ret = [storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];
    return ret;
}

- (NSUInteger)indexOfViewController:(aszSeqWebPageViewController *)viewController
{
    
    return 0 ;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [self.storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    aszSeqWebPageViewController *ret = [self.storyboard instantiateViewControllerWithIdentifier:@"aszSeqWebPageViewController"];

    return ret;
}


#pragma mark - UIPageViewController delegate methods

-(UIPageViewControllerSpineLocation) pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
//    UIViewController *currentViewController = self.viewControllers[0];
//    NSArray *viewControllers = @[currentViewController];
//    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
//    
//    self.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
    
}


@end
