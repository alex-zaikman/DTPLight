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
 
 classes:[
 {
 classId:
 schoolId:
 className:
 classImageId:
 classImageUrl:  // starting with "/"
 },....
 
 ]
 */

#import "aszUserClassesData.h"
#import "LmsConnectionRestApi.h"
#import "aszUserData.h"
#import "aszJsonDictionarryManip.h"

@interface aszUserClassesData()

@property (nonatomic,strong) NSMutableDictionary *retData;
@end

@implementation aszUserClassesData



@synthesize retData=_retData;

-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{

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
        
    //get classes for user
        [LmsConnectionRestApi lmsGetTeacherStudyClassesFrom:domain teacherId:userId  OnSuccessCall:^(NSArray* ddata){
                
                //parce and extract relevant data
                
            NSMutableArray *classes = [[NSMutableArray alloc]initWithCapacity:[ddata count]];
            for (NSDictionary *dclass in ddata) {
                
                NSMutableDictionary *class =[[NSMutableDictionary alloc]initWithCapacity:5];
                
                [class setValue:[dclass valueForKey:@"id"] forKey:@"classId"];
                [class setValue:[dclass valueForKey:@"schoolId"] forKey:@"schoolId"];
                [class setValue:[dclass valueForKey:@"name"] forKey:@"className"];
                
                NSNumber *imageId = [dclass valueForKey:@"imageId"];
                [class setValue:imageId forKey:@"classImageId"];
                //get url for image
                
                NSMutableString *imgUrl = [[NSMutableString alloc]init];
                
                
                [imgUrl appendString:@"/lms/rest/schools/"];
                [imgUrl appendString:[[dclass valueForKey:@"schoolId"]stringValue]];
                [imgUrl appendString:@"/images/"];
                [imgUrl appendString:[imageId stringValue]];
                
                [class setValue:[imgUrl copy] forKey:@"classImageUrl"];
                 
                //add the class to classes
               [classes addObject:[class copy]];
                
            }
            
            //add classes to ret data
             [self.retData setObject:classes forKey:@"classes"];
            
            //return with success
            fnsuccess([self.retData copy]);
          
            
        } onFailureCall:fnfaliure];
        
        
                
    } onFailureCall:fnfaliure];
 
    
    
}

@end
















