//
//  aszLessonSequensesData.h
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszLessonSequensesData : NSObject


-(void)getDataQueryDomain:(NSString*)domain withClassId:(NSString*)classid withCourseId:(NSString*)courseid andLessonId:(NSString*)lessonid andLessonTitle:(NSString*)loTitle OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

@end
