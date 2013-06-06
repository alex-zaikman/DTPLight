/*
 {
 
 courseId:


 
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
 
 lesson:{
 cid:
 title:
 }
 
 book:{
    bookOverview:
    bookCredits:
    bookImageUrl:  //optional
    courseCid:
 }
 
 loDataCid:
 
 learningObjects: [
 {
 cid:
 title:   //optional
 
 sequences: [
 {
 cid:
 title:
 contentUrl: 
 thumbnailUrl:
 
 },...]
 
 
 },...]
 
 */

#import "aszLessonSequensesData.h"
#import "aszCourseContentData.h"
#import "LmsConnectionRestApi.h"

@interface aszLessonSequensesData ()

@property (nonatomic,strong) NSString *domain;
@property (nonatomic,strong) NSNumber * userid;
@property (nonatomic,strong) NSString *courseid;
@property (nonatomic,strong) NSString *lessonid;
@property (nonatomic,strong) NSDictionary *retData;
@property (nonatomic,strong) NSString *loTitle;
@property (nonatomic,strong) NSString *classid;
@end


@implementation aszLessonSequensesData

@synthesize domain=_domain;
@synthesize userid=_userid;
@synthesize courseid=_courseid;
@synthesize lessonid=_lessonid;
@synthesize retData=_retData;
@synthesize loTitle=_loTitle;
@synthesize classid=_classid;

-(void)getDataQueryDomain:(NSString*)domain withClassId:(NSString*)classid withCourseId:(NSString*)courseid andLessonId:(NSString*)lessonid andLessonTitle:(NSString*)loTitle OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
   
    //initialization
    self.retData = [[NSMutableDictionary alloc]init];
    
    __block void (^fnsuccess)(NSDictionary *);
    __block void (^fnfaliure)(NSError *);
    
    fnsuccess=success;
    fnfaliure=faliure;
    
    self.classid=classid;
    self.domain=domain;
    self.loTitle =loTitle;
    self.courseid=courseid;
    self.lessonid=lessonid;
    
    
    
    
    //get user data
    aszCourseContentData *ucd = [[aszCourseContentData alloc]init];
    [ucd getDataQueryDomain:self.domain forClassId:[self.classid integerValue]  OnSuccessCall:^(NSDictionary *ucdDic) {
        
        
     
        
        
        [self.retData setValue:[[ucdDic valueForKey:@"user"]copy] forKey:@"user"];
        
        //set lesson data
        NSDictionary *lo = [[NSDictionary alloc]initWithObjectsAndKeys: self.lessonid,@"cid", self.loTitle, @"title", nil];
        
        [self.retData setValue:lo  forKey:@"lesson"];
        
        [self.retData setValue:[[ucdDic valueForKey:@"book"]copy] forKey:@"book"];

        //collect data
        [self.retData setValue:self.lessonid forKey:@"lessonCid"];
        [self.retData setValue:self.courseid forKey:@"courseId"];

        NSString *bookCourseCid = [[ucdDic valueForKey:@"book"] valueForKey:@"courseCid"];
        
        [LmsConnectionRestApi lmsGetCourseLessonFrom:self.domain courseId:self.courseid lessonCid:self.lessonid OnSuccessCall:^(NSDictionary *clDic) {
            
                       //extarct
            /*
             learningObjects: [
             {
             cid:
             title:   //optional
             
             sequences: [
             {
             cid:
             title:
             contentUrl: 
             contentJson:
             thumbnailUrl:
             
             },...]
             
             
             },...]
             */
            
            [self.retData setValue:[[clDic valueForKey:@"data"] valueForKey:@"cid"] forKey:@"loDataCid"];
            
            NSArray *resources = [[clDic valueForKey:@"data"] valueForKey:@"resources"];
            
            NSMutableArray *learningObjects = [[NSMutableArray alloc]init];
            

            NSArray *srcLearningObjects = [[clDic valueForKey:@"data"] valueForKey:@"learningObjects"];
            for(NSDictionary *srcLo in srcLearningObjects){
            
                NSMutableDictionary *lo=[[NSMutableDictionary alloc]init];
                
                //get lo cid
                [lo setValue:[srcLo valueForKey:@"cid"] forKey:@"cid"];

                ///get lo title if any
                NSString *title = [srcLo valueForKey:@"title"] ;
                if(title)
                    [lo setValue:title forKey:@"title"];
                
                //go over seqs
                NSMutableArray *seqs = [[NSMutableArray alloc]init];
                
                NSArray *srcSeqs = [srcLo valueForKey:@"sequences"];
                for(NSDictionary *srcSeq in srcSeqs){
                    NSMutableDictionary *seq =[[NSMutableDictionary alloc]init];
                    
                    [seq setValue:[srcSeq valueForKey:@"cid"] forKey:@"cid"];
                    [seq setValue:[srcSeq valueForKey:@"title"] forKey:@"title"];
                    
                    NSMutableString *suburl = [[NSMutableString alloc]init];
                    
                    [suburl appendString:self.domain];
                    
                    [suburl appendString:@"/cms/courses/"];
                    
                    [suburl appendString:bookCourseCid];
                    
                    [suburl appendString:@"/"];
                    
                    
                    
                    
                    for(NSDictionary *res in resources){
                        
                        if([[res valueForKey:@"resId"] isEqualToString: [srcSeq valueForKey:@"thumbnailRef"] ]){
                            [seq setValue: [suburl stringByAppendingString: [res valueForKey:@"href"]   ] forKey:@"thumbnailUrl"];
                        }
                        
                        else if([[res valueForKey:@"resId"] isEqualToString: [srcSeq valueForKey:@"contentRef"] ]){
                                [seq setValue: [suburl stringByAppendingString: [res valueForKey:@"href"]   ] forKey:@"contentUrl"];
                            }
                    }
            
                    [seqs addObject:[seq copy]];
                }
            
                //add seqs to lo
                [lo setValue:[seqs copy] forKey:@"sequences"];
                
                [learningObjects addObject:lo];
            }
            
            [self.retData setValue:learningObjects forKey:@"learningObjects"];
            
             
            fnsuccess(self.retData);
            
        } onFailureCall:^(NSError *e) {
            fnfaliure(e);
        }];
        
    } onFailureCall:^(NSError *e) {
        fnfaliure(e);
    }];
    
    

    
    
    
  
    
    
}



@end

















