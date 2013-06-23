//
//  aszSeqWebPageViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqWebPageViewController.h"
#import "aszHttpConnectionHandler.h"

@interface aszSeqWebPageViewController ()

@end

@implementation aszSeqWebPageViewController



- (void)prepRequestWith:(NSString *)jsonDataString andCourseId:(NSString *)courseId named:(NSString *)seqTitle
{
    
    self.dlLable.text=seqTitle;
 
    NSString *urlAddress = @"https://cto.timetoknow.com/cms/player/dl/index2.jsp";
    
    NSMutableString *mediaUrl=[[NSMutableString alloc]init];
    
    [mediaUrl appendString: @" &mediaUrl= \"/cms/courses/"];
    
    [mediaUrl appendString: courseId];
    [mediaUrl appendString: @"/\""];
    
    jsonDataString = [@"jsonStr=" stringByAppendingString:jsonDataString];
    
    jsonDataString =[jsonDataString stringByAppendingString:mediaUrl];
    
    jsonDataString = [jsonDataString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [aszHttpConnectionHandler requestWithUrl:urlAddress usingMethod:@"POST" withUrlParams:nil andBodyData:jsonDataString];
    
    [self.dlWebView loadRequest:request];
    
}

@end
