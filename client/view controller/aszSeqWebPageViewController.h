//
//  aszSeqWebPageViewController.h
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszSeqWebPageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dlLable;

@property (weak, nonatomic) IBOutlet UIWebView *dlWebView;

- (void)prepRequestWith:(NSString *)jsonDataString andCourseId:(NSString *)courseId named:(NSString *)seqTitle;

@end
