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
 
 book:{
   bookOverview:
   bookCredits:
   bookImageUrl:  //optional
 }
 
 toc:{
    overview:
    title:
    cid:
 
    tocItems[{                                   //optional
            overview:
            title:
            cid:
 
            tocItems:[{....}]                   //optional
            lessons:[{...]}                     //optional
 
    },...]
 
 
    lessons:[{                                  //optional
        title:
        cid:
 
    },...]
 
    }
 }
 */
#import "aszCourseContentData.h"
#import "aszUserData.h"
#import "LmsConnectionRestApi.h"


@interface aszCourseContentData()

@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,strong) NSMutableDictionary *retData;

+(NSDictionary*) extractTocsFrom:(NSDictionary*) dic;


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
            

                 [LmsConnectionRestApi lmsCourseDataFrom:domain withId:courseId OnSuccessCall:^(NSDictionary * json) {

                     NSDictionary *data = [json valueForKey:@"data"];
                      //get book data
                     NSString *bookoverview = [data valueForKey:@"overview"];
                     NSString *bookcredits = [data valueForKey:@"credits"];
                     
                     NSString *bookcover = [data valueForKey:@"coverRefId"];
                     
                     NSArray *resoursesArr =  [data valueForKey:@"resources"];
                     for (NSDictionary *ref in resoursesArr) {
                         if([(NSString*)[ref valueForKey:@"resId"] isEqualToString:bookcover]){
                             bookcover=[ref valueForKey:@"href"];
                             
                             NSMutableString *bookcoverurl=[[NSMutableString alloc]init];
                             [bookcoverurl appendString:domain];
                             [bookcoverurl appendString:@"/cms/courses/"];
                             [bookcoverurl appendString: [data valueForKey:@"courseId"]];
                             [bookcoverurl appendString:bookcover];
                             
                             bookcover = bookcoverurl;
                             
                             break;
                             }
                         bookcover = nil;
                     }
                     
                     NSMutableDictionary *book=[[NSMutableDictionary alloc]init];
                     
                     [book setValue:bookoverview forKey:@"bookOverview"];
                     [book setValue:bookcredits forKey:@"bookCredits"];
                     
                     if(bookcover!=nil)
                          [book setValue:bookcover forKey:@"bookImageUrl"];
                     
                     //add book to data
                     [self.retData setValue:[book copy]  forKey:@"book"];
                     
                     //get toc data
                     NSDictionary *toc = [data valueForKey:@"toc"];
                     NSMutableDictionary *course =[[NSMutableDictionary alloc]init];
                     
                     [course setValue:[toc valueForKey:@"title"] forKey:@"title"];
                     [course setValue:[toc valueForKey:@"overview"] forKey:@"overview"];
                     
                     // extract tocitems and lessons
                 //    tocItems
                     
                 //    lessons
                     
                     
                     //add course to ret data
                      [self.retData setValue:[course copy]  forKey:@"toc"];
                     
                 } onFailureCall:fnfaliure];
            }
        } onFailureCall:fnfaliure];
     } onFailureCall:fnfaliure];
}



+(NSDictionary*) extractTocsFrom:(NSDictionary*) dic{

    NSMutableDictionary *retDic=[[NSMutableDictionary alloc]init];
    
    NSMutableArray *newLessonArray=[[NSMutableArray alloc]init];
    NSArray *lessonsArr;
    
    if((lessonsArr = [dic valueForKey:@"lessons"])!=nil){
        for (NSDictionary * lesson in lessonsArr){
             NSMutableDictionary *newLesson=[[NSMutableDictionary alloc]init];
            [newLesson setValue:[lesson valueForKey:@"title"] forKey:@"title"];
            [newLesson setValue:[lesson valueForKey:@"cid"] forKey:@"cid"];
            [newLessonArray addObject:[newLesson copy]];
        }
        [retDic setValue:newLessonArray forKey:@"lessons"];
    }
    
    NSDictionary *tocDic;
    if(([dic valueForKey:@"tocItems"])!=nil){
    
        [retDic setVlaue:[[self class] extractTocsFrom:tocDic] forKey:@"tocItems"];
        
    }
    
    
    
    return retDic;
}

@end










