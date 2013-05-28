//
//  aszHttpConnectionHandler.m
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszHttpConnectionHandler.h"

@interface aszHttpConnectionHandler() <NSURLConnectionDelegate>

@property NSURLConnection *connection;


@end

@implementation aszHttpConnectionHandler

@synthesize connection=_connection;

void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);


-(void)execRequest:(NSURLRequest*)request  OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure {
 
    fnsuccess=success;
    fnfaliure=faliure;
    
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
}

//connection call back

- (void) didReceiveData:(NSData *)data{
    
    NSError *error;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers error:&error];
    
    fnsuccess(dic);
}

- (void) didFailWithError:(NSError *)error{
    fnfaliure(error);
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    fnsuccess(nil);
}

- (void) didFinishLoading{
    //
}


//static helper functions

+(NSURLRequest*)requestWithUrl:(NSString*)url usingMethod:(NSString*)method withUrlParams: (NSDictionary*)urlVars andBodyData:(NSString*)bodyData {
    
    NSString *vurl = url;
    
    if(urlVars!=nil && [urlVars count]>0)
        vurl = [url stringByAppendingString:[ aszHttpConnectionHandler paramsToString:urlVars]];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: vurl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    if( method!=nil)
        [request setHTTPMethod:method];
    
    if(bodyData!=nil)
        [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    
    return [request copy];
}


+(NSString*)paramsToString:(NSDictionary*)vars{
    
    NSMutableString *getVars;
    
    [getVars appendString:@"?"];
    
    NSEnumerator *it = [vars keyEnumerator];
    
     for(NSString *aKey in it) {
         getVars = [[getVars stringByAppendingString:aKey]mutableCopy];
         getVars = [[getVars stringByAppendingString:@"="]mutableCopy];
         getVars = [[getVars stringByAppendingString:[vars valueForKey:aKey]]mutableCopy];
         getVars = [[getVars stringByAppendingString:@"&"]mutableCopy];
     }
    [getVars substringToIndex:[getVars length] - 1];
    
    return getVars;
}



@end
