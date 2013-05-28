//
//  aszViewController.m
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSplitViewController.h"

@interface aszSplitViewController ()

@end

@implementation aszSplitViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
}


-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    return YES;
}

@end
