//
//  LmsConnectionRestApi.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsConnectionRestApi.h"
#import "aszHttpConnectionHandler.h"

@interface LmsConnectionRestApi()



@end

@implementation LmsConnectionRestApi

+ (void) lmsGetAppDataFrom:(NSString*)domain dictionaryModified:(NSNumber*)modified OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
   
    //call get request with api suffix
  NSDictionary* vars=nil;
  
  if(modified!=nil)
      vars = [[NSDictionary alloc]initWithObjectsAndKeys:@"dictionaryModified", [modified stringValue] , nil];
    
  NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
    
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
         handler = [[aszHttpConnectionHandler   alloc]init];

 NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: vars andBodyData:nil];

 [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}

///schools/8/images/7
+ (void) lmsGetImageFrom:(NSString*)domain withSchoolId:(NSNumber*)schoolid andImageId:(NSNumber*)imageid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/images"];
    [url appendString:[imageid stringValue]];

    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler =[[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
   [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}



+ (void) lmsGetTeacherStudyClassesFrom:(NSString*)domain teacherId:(NSNumber*)teacherid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
   
    [url appendString:domain];
    [url appendString:@"/lms/rest/teachers/"];
    [url appendString:[teacherid stringValue]];
    [url appendString:@"/studyclasses"];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
}

+ (void) lmsGetStudentStudyClassesFrom:(NSString*)domain studentId:(NSNumber*)studentid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/students/"];
    [url appendString:[studentid stringValue]];
    [url appendString:@"/studyclasses"];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain byQuery:(NSString*)query OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:@"query", query , nil];
    
    NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
   
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: vars andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain BySchoolId:(NSNumber*)schoolid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/courseinfos"];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
}



+ (void) lmsGetCoursesInfosFrom:(NSString*)domain userId:(NSNumber*)userid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/usercourseinfos"];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}

+ (void) lmsGetCourseManifestFrom:(NSString*)domain courseId:(NSNumber*)courseid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
 
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:[courseid stringValue]];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];

}

+ (void) lmsGetCourseLessonFrom:(NSString*)domain courseId:(NSString*)courseid lessonCid:(NSString*)lessonCid  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:courseid];
    [url appendString:@"/lessons/"];
    [url appendString:lessonCid];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
}


+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid   OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/studyclassstates"];

    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}


+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid associated:(BOOL)associated  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/studyclassstates"];
    
    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:@"associated", associated?@"true":@"false" ,@"associated" , nil];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}


+ (void) lmsCourseDataFrom:(NSString*)domain withId:(NSString*)courseid  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
        
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:courseid];
    
    static aszHttpConnectionHandler *handler;
    if(!handler)
        handler = [[aszHttpConnectionHandler   alloc]init];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    [handler execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}




@end
