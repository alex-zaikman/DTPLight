//
//  aszHttpConnectionHandler.h
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszHttpConnectionHandler : NSObject

-(void)execRequest:(NSURLRequest*)request  OnSuccessCall:(void (^)(NSData *)) success onFailureCall:(void (^)(NSError*)) faliure;

+(NSURLRequest*)requestWithUrl:(NSString*)url usingMethod:(NSString*)method withUrlParams: (NSDictionary*)urlVars andBodyData:(NSString*)bodyData;

+(NSString*)paramsToString:(NSDictionary*)vars;



@end
