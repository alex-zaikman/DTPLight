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
#import "aszUserData.h"
#import "LmsConnectionRestApi.h"

@interface aszUserData ()

@property (nonatomic,strong) LmsConnectionRestApi *lms;

@end

@implementation aszUserData

@synthesize lms=_lms;


void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
   
    
    fnsuccess=success;
    fnfaliure=faliure;
    

    [LmsConnectionRestApi lmsGetAppDataFrom:domain dictionaryModified:nil OnSuccessCall:^(NSData* ddata){
        
        
     //  NSData* data = [dic dataUsingEncoding:NSUTF8StringEncoding];
      NSError *error=nil;
      NSDictionary *data = [NSJSONSerialization JSONObjectWithData:ddata options:kNilOptions error:&error];
        
     //   NSString *myString = [[NSString alloc] initWithData:ddata encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary* user = [[NSMutableDictionary alloc]initWithCapacity:6];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"id"] forKey:@"userId"];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"userName"] forKey:@"userName"];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"firstName"] forKey:@"firstName"];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"lastName"] forKey:@"lastName"];
        
        [user setValue:[[[data valueForKey:@"user"] valueForKey:@"roles"]objectAtIndex:0 ]forKey:@"role"];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"title"]forKey:@"title"];
        
        [user setValue:[[data valueForKey:@"user"] valueForKey:@"schoolId"]forKey:@"schoolId"];
        
        [user setValue:[data valueForKey:@"logoutUrl"] forKey:@"logoutUrl"];
        
        [user setValue:[[data valueForKey:@"school"]valueForKey:@"name"] forKey:@"schoolName"];
    
        fnsuccess([user copy]);
    
    } onFailureCall:fnfaliure];
    
}


@end
