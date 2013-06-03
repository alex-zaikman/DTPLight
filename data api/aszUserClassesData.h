

#import <Foundation/Foundation.h>

@interface aszUserClassesData : NSObject 

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

@end
