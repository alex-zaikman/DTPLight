//
//  aszHttpConnectionHandler.m
//  DTPLight
//
//  Created by alex zaikman on 5/28/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszHttpConnectionHandler.h"

@interface aszHttpConnectionHandler() <NSURLConnectionDelegate>

@property (nonatomic,strong) NSMutableData *urlData;
@property (nonatomic,strong) NSURLConnection *urlConnection;

@property (nonatomic,strong)  __block void  (^fnsuccess)(NSData *);
@property (nonatomic,strong)  __block void  (^fnfaliure)(NSError *);
    

@end

@implementation aszHttpConnectionHandler



@synthesize urlData=_urlData;
@synthesize urlConnection=_urlConnection;




-(void)execRequest:(NSURLRequest*)request  OnSuccessCall:(void (^)(NSData *)) success onFailureCall:(void (^)(NSError*)) faliure  {

    self.fnsuccess=success;
    self.fnfaliure=faliure;
    
     self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.urlConnection start];
    
}


//static helper functions

+(NSURLRequest*)requestWithUrl:(NSString*)url usingMethod:(NSString*)method withUrlParams: (NSDictionary*)urlVars andBodyData:(NSString*)bodyData {
    
    NSString *vurl = url;
    
    if(urlVars!=nil && [urlVars count]>0){
        vurl = [vurl stringByAppendingString:@"?"];
        vurl = [vurl stringByAppendingString:[ aszHttpConnectionHandler paramsToString:urlVars]];
    
    }
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: vurl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    if( method!=nil)
        [request setHTTPMethod:method];
    
    if(bodyData!=nil)
        [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    
    return [request copy];
}


+(NSString*)paramsToString:(NSDictionary*)vars{
    
    NSMutableString *getVars=[[NSMutableString alloc]init];
    
  //  [getVars appendString:@"?"];
    
    NSEnumerator *it = [vars keyEnumerator];
    
     for(NSString *aKey in it) {
         getVars = [[getVars stringByAppendingString:aKey]mutableCopy];
         getVars = [[getVars stringByAppendingString:@"="]mutableCopy];
         getVars = [[getVars stringByAppendingString:[vars valueForKey:aKey]]mutableCopy];
         getVars = [[getVars stringByAppendingString:@"&"]mutableCopy];
     }
   NSString*  ret = [getVars substringToIndex:[getVars length] - 1];
    
    return ret;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.urlData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.fnsuccess(self.urlData);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.fnfaliure(error);
}

@end
