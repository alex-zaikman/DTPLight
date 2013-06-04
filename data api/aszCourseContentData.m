/*
 {
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
 
 courseId:  
 
 
 
 
 }
 */
#import "aszCourseContentData.h"
#import "aszUserData.h"
#import "LmsConnectionRestApi.h"


@interface aszCourseContentData()

@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,strong) NSMutableDictionary *retData;

@end
@implementation aszCourseContentData : NSObject

@synthesize cid=_cid;
@synthesize retData=_retData;


-(void)getDataQueryDomain:(NSString*)domain forClassId:(NSInteger) cid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{

    self.cid=cid;
    self.retData = [[NSMutableDictionary alloc]init];
    
    __block void (^fnsuccess)(NSDictionary *);
    __block void (^fnfaliure)(NSError *);
    
    fnsuccess=success;
    fnfaliure=faliure;
    
    //get user data
    aszUserData *user = [[aszUserData alloc]init];
    [user getDataQueryDomain:domain OnSuccessCall:^(NSDictionary *userDic) {
        
        //add to return data dic
        [self.retData setObject:userDic forKey:@"user"];
        //extract teacherId
        NSNumber *userId = [userDic valueForKey:@"userId"];
        
        
        [LmsConnectionRestApi lmsAssociateCourseToUserFrom:domain toUserId:userId OnSuccessCall:^(NSArray *arr) {
     
            NSString *courseId=@"nil";
            
            for(NSDictionary *dic in arr){
                //if found get the courseId and breack
                if([((NSNumber*)[dic valueForKey:@"studyClassId"])isEqualToNumber:[NSNumber numberWithInteger:self.cid]])
                {
                    courseId = [dic valueForKey:@"courseId"];
                    break;
                }
            }
            
            //if no assosiated course fount return nil
            if((courseId==nil)||[courseId isEqualToString:@"nil"] ){
                fnsuccess(nil);
            }else{
                [self.retData setValue:courseId forKey:@"courseId"];

                
                
            
            hghtgh
            
            }
        } onFailureCall:fnfaliure];
     } onFailureCall:fnfaliure];
}

@end
