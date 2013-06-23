//
//  aszWebDlViewController.h
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszWebDlViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic,strong) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UIWebView *dlWebView;

@property (nonatomic,strong) UIPopoverController *masterPop;

@property (nonatomic,weak) id<UISplitViewControllerDelegate> backdelegate;

@end
