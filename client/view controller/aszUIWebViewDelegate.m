//
//  aszUIWebViewDelegate.m
//  DTPLight
//
//  Created by alex zaikman on 6/24/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszUIWebViewDelegate.h"

@interface aszUIWebViewDelegate()




@end

@implementation aszUIWebViewDelegate



-(id)initWtihData:(NSArray*)data{
    self=[super init];
    if(self){
        
        _data=data;
        
    }return self;
}



-(void) webViewDidFinishLoad:(UIWebView *)webView{

    
        NSMutableString *js=[[NSMutableString alloc]init];
    
        [js appendString:@"window.dlhost.initAndPlay("];
        
        [js appendString:self.data[0]];
    
        [js appendString:@"        ,     "];
    
        [js appendString:self.data[1]];
    
        [js appendString:@");"];
    
    //NSLog(@"%@",js);
    
    
    NSMutableString *javaScript =[[NSMutableString alloc]init];
    [javaScript appendString: @"var boo =function(){   setTimeout(function(){  "];
    [javaScript appendString:js  ];
    [javaScript appendString: @"   },0);    };  "];
    
    [webView stringByEvaluatingJavaScriptFromString: javaScript ];
 

}


@end
