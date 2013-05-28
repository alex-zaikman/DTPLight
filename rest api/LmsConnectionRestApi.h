//
//  LmsConnectionRestApi.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//


@interface LmsConnectionRestApi : NSObject


/**
 *
 * Returns initial common data for application, such as user info, school info, translations. 
 * User will be retrieved from session on the server therefore login is a prerequisite.
 * 
 * dictionaryModified is optional
 */
+ (void) lmsGetAppDataFrom:(NSString*)domain dictionaryModified:(NSNumber*)modified OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/**
 * Get dynamic image stored on server db (such as school logo, study class icon)
 */
+ (void) lmsGetImageFrom:(NSString*)domain withSchoolId:(NSNumber*)schoolid andImageId:(NSNumber*)imageid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;
/*
 * Get study classes assigned to the teacher
*/
+ (void) lmsGetTeacherStudyClassesFrom:(NSString*)domain teacherId:(NSNumber*)teacherid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/*
 * Get study classes of a student
 */
+ (void) lmsGetStudentStudyClassesFrom:(NSString*)domain studentId:(NSNumber*)studentid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;


/*
 * Returns a list of Courses info from GCR. 
 */
+ (void) lmsGetCoursesListFrom:(NSString*)domain byQuery:(NSString*)query OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/*
 * Returns a list of Courses info associated to the school.
 * A Course info contains headers without TOC
 */
+ (void) lmsGetCoursesListFrom:(NSString*)domain BySchoolId:(NSNumber*)schoolid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;


/*
 * Returns a list of Courses Infos associated to a teacher.
 * A Course info contains headers without TOC and list of study classes associated to the course
 */
+ (void) lmsGetCoursesInfosFrom:(NSString*)domain userId:(NSNumber*)userid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/*
 * Returns the full Course manifest associated to the user. 
 */
+ (void) lmsGetCourseManifestFrom:(NSString*)domain courseId:(NSNumber*)courseid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/*
 * Returns the full course lesson. 
 */
+ (void) lmsGetCourseLessonFrom:(NSString*)domain courseId:(NSString*)courseid lessonCid:(NSString*)lessonCid  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

/*
 *Get classes associated to user
 */
+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid associated:(BOOL)associated OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

+ (void) lmsAssociateCourseToUserFrom:(NSString*)domain toUserId:(NSNumber*)userid   OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;
/*
 *  Get Course - Returns the full Course manifest associated to the user. 
 */
+ (void) lmsCourseDataFrom:(NSString*)domain withId:(NSString*)courseid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;


//TODO add the rest of the rest api...
@end
