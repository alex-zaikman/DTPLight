//
//  aszViewController.m
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSplitViewController.h"

@interface aszSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation aszSplitViewController

- (void)awakeFromNib {
    self.delegate=self;
    
    [super awakeFromNib];
   
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
    
}



@end
