//
//  aszCourseContentData.h
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszCourseContentData : NSObject

-(void)getDataQueryDomain:(NSString*)domain forClassId:(NSInteger) cid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

@end
