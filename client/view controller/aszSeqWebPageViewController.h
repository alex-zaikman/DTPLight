//
//  aszSeqWebPageViewController.h
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszSeqWebPageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *pageCount;

@property (strong, nonatomic)  UIWebView *dlWebView;

@property (nonatomic,assign) int index;

@property (nonatomic,strong) NSArray *req;

-(void) startLoadingWithTitle: (NSString*)title;

@end
