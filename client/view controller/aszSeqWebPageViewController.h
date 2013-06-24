//
//  aszSeqWebPageViewController.h
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszSeqWebPageViewController : UIViewController



@property (strong, nonatomic)  UIWebView *dlWebView;

@property (nonatomic,assign) int index;

@property (nonatomic,strong) NSURLRequest *req;

-(void) startLoading;

@end
