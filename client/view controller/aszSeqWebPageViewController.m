//
//  aszSeqWebPageViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/23/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSeqWebPageViewController.h"
#import "aszHttpConnectionHandler.h"

@interface aszSeqWebPageViewController ()

@end

@implementation aszSeqWebPageViewController


- (IBAction)dissmisModal:(id)sender {
    
  [[self parentViewController] dismissModalViewControllerAnimated:YES];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        
   //  [_dlWebView loadRequest:self.req];
        
        
    }
    return self;
    
}

-(void)viewDidLoad{
    
   // [self.dlWebView loadRequest:self.req];
    
}

@end
