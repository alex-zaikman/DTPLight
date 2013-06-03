
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



+ (void) lmsLogoutLms:(NSString*)domain OnSuccessCall:(void (^)(NSData *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:domain usingMethod:@"GET" withUrlParams: nil andBodyData: nil ];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:success onFailureCall:faliure];

}

+ (void) lmsLoginLms:(NSString*)domain action:(NSString*)action postVars:(NSDictionary*)vars  OnSuccessCall:(void (^)(NSData *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:domain];
    [url appendString:action];
    
    NSMutableString *bodydata =[[NSMutableString alloc]initWithString:[aszHttpConnectionHandler paramsToString:vars]];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"POST" withUrlParams: nil andBodyData: bodydata ];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}


+ (void) lmsPingLms:(NSString*)domain OnSuccessCall: (void (^)(NSString *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:domain];
    [url appendString:@"/lms"];
    
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* d){
        
        success([[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding]);
    
    } onFailureCall:faliure];
    
}



+ (void) lmsGetAppDataFrom:(NSString*)domain dictionaryModified:(NSNumber*)modified OnSuccessCall:(void (^)(NSData *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
   
    //call get request with api suffix
  NSDictionary* vars=nil;
  
  if(modified!=nil)
      vars = [[NSDictionary alloc]initWithObjectsAndKeys:@"dictionaryModified", [modified stringValue] , nil];
    
  NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
    
    

 NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: vars andBodyData:nil];

    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:success onFailureCall:faliure];
    
}

///schools/8/images/7
+ (void) lmsGetImageFrom:(NSString*)domain withSchoolId:(NSNumber*)schoolid andImageId:(NSNumber*)imageid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/images"];
    [url appendString:[imageid stringValue]];

    

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}



+ (void) lmsGetTeacherStudyClassesFrom:(NSString*)domain teacherId:(NSNumber*)teacherid OnSuccessCall:(void (^)(NSArray *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
   
    [url appendString:domain];
    [url appendString:@"/lms/rest/teachers/"];
    [url appendString:[teacherid stringValue]];
    [url appendString:@"/studyclasses"];
    
   
   
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSArray *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}

+ (void) lmsGetStudentStudyClassesFrom:(NSString*)domain studentId:(NSNumber*)studentid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/students/"];
    [url appendString:[studentid stringValue]];
    [url appendString:@"/studyclasses"];

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain byQuery:(NSString*)query OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:@"query", query , nil];
    
    NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
   

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: vars andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain BySchoolId:(NSNumber*)schoolid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/courseinfos"];
    

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}



+ (void) lmsGetCoursesInfosFrom:(NSString*)domain userId:(NSNumber*)userid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/usercourseinfos"];
    
  

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
    
}

+ (void) lmsGetCourseManifestFrom:(NSString*)domain courseId:(NSNumber*)courseid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
 
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:[courseid stringValue]];
    
    
  
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];

}

+ (void) lmsGetCourseLessonFrom:(NSString*)domain courseId:(NSString*)courseid lessonCid:(NSString*)lessonCid  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:courseid];
    [url appendString:@"/lessons/"];
    [url appendString:lessonCid];
    
   
  
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
}


+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid   OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/studyclassstates"];

    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
    
}


+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid associated:(BOOL)associated  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/studyclassstates"];
    
    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:associated?@"true":@"false" ,@"associated" , nil];
    
 
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: vars andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
    
}


+ (void) lmsCourseDataFrom:(NSString*)domain withId:(NSString*)courseid  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
        
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:courseid];
    
   
    NSURLRequest* req =[aszHttpConnectionHandler requestWithUrl:url usingMethod:@"GET" withUrlParams: nil andBodyData:nil];
    
    aszHttpConnectionHandler *hndl = [[aszHttpConnectionHandler alloc]init];
    
    [hndl execRequest:req OnSuccessCall:^(NSData* data){
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error)
            faliure(error);
        else
            success(dictionary);
        
    } onFailureCall:faliure];
    
}




@end
