/*
user:{
 
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

#import "aszUserClassesData.h"
#import "LmsConnectionRestApi.h"
#import "aszUserData.h"
#import "aszJsonDictionarryManip.h"

@interface aszUserClassesData()

@property (nonatomic,strong) NSMutableDictionary *retData;
@end

@implementation aszUserClassesData

void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);

@synthesize retData=_retData;

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{

    self.retData = [[NSMutableDictionary alloc]init];
    
    fnsuccess=success;
    fnfaliure=faliure;
    
    
    //get user data
    aszUserData *user = [[aszUserData alloc]init];
    [user getDataQueryDomain:domain OnSuccessCall:^(NSDictionary *userDic) {
        
        //add to return data dic
        [self.retData setObject:userDic forKey:@"user"];
        //extract teacherId
        NSNumber *userId = [userDic valueForKey:@"userId"];
        
    //get classes for user
        [LmsConnectionRestApi lmsGetTeacherStudyClassesFrom:domain teacherId:userId  OnSuccessCall:^(NSDictionary* ddata){
            
            
          //      NSString *debugString = [aszJsonDictionarryManip dictionarryToPrintableString:ddata];////debug
                
                //parce and extract relevant data
                
            
                fnsuccess([self.retData copy]);
          
            
        } onFailureCall:fnfaliure];
        
        
                
    } onFailureCall:fnfaliure];
 
    
    
}

@end
















