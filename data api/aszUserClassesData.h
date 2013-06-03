//
//  aszUserCoursesData.h
//  DTPLight
//
//  Created by alex zaikman on 6/2/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszUserClassesData : NSObject

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;


@end
