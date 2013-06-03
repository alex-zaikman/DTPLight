
/*
 :{
 
 userId:
 userName:
 firstName:
 lastName:
 title:      //Mr,Ms ....
 role:
 schoolId
 schoolName:
 logOut:   //url
 
 }
 */


#import <Foundation/Foundation.h>

@interface aszUserData : NSObject

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

@end
