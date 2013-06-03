/*
 
return userData
 
 */

#import <Foundation/Foundation.h>

@interface aszLogin : NSObject

- (void) LogInTo:(NSString*)domain asUser:(NSString *)user
                                   withPassword:(NSString*)password
                                   onSuccessCall:(void (^)(NSData *)) success
                                   onFailureCall:(void (^)(NSError*)) faliure;


-(void)logoutFrom:(NSString*)domain  onSuccessCall:(void (^)(NSData *)) success
    onFailureCall:(void (^)(NSError*)) faliure;

@end
