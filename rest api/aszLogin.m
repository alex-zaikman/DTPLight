//
//  aszLogin.m
//  DTPLight
//
//  Created by alex zaikman on 6/2/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszLogin.h"
#import "LmsConnectionRestApi.h"
#import "aszUserData.h"
#import "aszJsonDictionarryManip.h"


@interface aszLogin ()


@property (nonatomic,strong) NSString* domain;
@property (nonatomic,strong) NSString* user;
@property (nonatomic,strong) NSString* password;


@end

@implementation aszLogin

void (^fnsuccess)(NSData *);
void (^fnfaliure)(NSError *);


@synthesize domain=_domain;
@synthesize password=_password;
@synthesize user=_user;



- (void) LogInTo:(NSString*)domain asUser:(NSString *)user
    withPassword:(NSString*)password
   onSuccessCall:(void (^)(NSData *)) success
   onFailureCall:(void (^)(NSError*)) faliure{
    
    self.domain=domain;
    self.user=user;
    self.password=password;

    fnfaliure=faliure;
    fnsuccess=success;

 
    [LmsConnectionRestApi lmsPingLms:self.domain OnSuccessCall:^(NSString* dic){
        
        
            NSString *data =  dic;
            
            //find action
            //<form id="fm1" class="myForm" action="/cas/login;jsessionid=20EA8F72F3C53BCC08E957169AC93DBE?service=https%3A%2F%2Fcto.timetoknow.com%2Flms%2F&amp;t2kRedirect=https%3A%2F%2Fcto.timetoknow.com%2Flms%2F" method="post">
            NSRange range = [data rangeOfString:@"action=\"" ];
            NSString*  action= [ data substringFromIndex:range.location+range.length];
            action  = [action substringToIndex:[action rangeOfString:@"\" method=" ].location];
            
            
            
            //find lt
            //<input type="hidden" name="lt" value="LT-55-2NTupLsLgFuri03y5SuYWMvZYaw6Lm" />
            range = [data rangeOfString:@"<input type=\"hidden\" name=\"lt\" value=\"" ];
            NSString*  lt= [ data substringFromIndex:range.location+range.length];
            lt  = [lt substringToIndex:[lt rangeOfString:@"\" />"].location];
            
            
            //find execution
            //<input type="hidden" name="execution" value="e1s1" />
            range = [data rangeOfString:@"<input type=\"hidden\" name=\"execution\" value=\"" ];
            NSString*  execution= [ data substringFromIndex:range.location+range.length];
            execution  = [execution substringToIndex:[execution rangeOfString:@"\" />" ].location];
            
            
            //find _eventId
            //<input type="hidden" name="_eventId" value="submit" />
            range = [data rangeOfString:@"<input type=\"hidden\" name=\"_eventId\" value=\"" ];
            NSString*  eventId= [ data substringFromIndex:range.location+range.length];
            eventId  = [eventId substringToIndex:[eventId rangeOfString:@"\" />" ].location];
        
             NSMutableDictionary *vars = [[NSMutableDictionary alloc]init];
            
            
            [vars setObject:self.password forKey:@"password"];
            [vars setObject:self.user forKey:@"username"];
            [vars setObject:lt forKey:@"lt"];
            [vars setObject:execution forKey:@"execution"];
            [vars setObject:eventId forKey:@"_eventId"];
        
        
        
        [LmsConnectionRestApi lmsLoginLms:self.domain action:action postVars:[vars copy] OnSuccessCall:fnsuccess onFailureCall:fnfaliure];
    
     
    } onFailureCall:fnfaliure];
    
}




-(void)logoutFrom:(NSString*)domain  onSuccessCall:(void (^)(NSData *)) success
    onFailureCall:(void (^)(NSError*)) faliure{
    
    aszUserData *ud =[[aszUserData alloc]init];
    [ud getDataQueryDomain:(NSString*)domain OnSuccessCall:^(NSDictionary* dic){
    
      NSString *logoutUrl = [dic valueForKey:@"logoutUrl"];
      
     [LmsConnectionRestApi lmsLogoutLms:logoutUrl OnSuccessCall:success onFailureCall:faliure];
        
    } onFailureCall:faliure];
}

@end












