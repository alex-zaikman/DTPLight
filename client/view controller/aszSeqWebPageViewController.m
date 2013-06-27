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

@property (nonatomic,strong) NSString* title;

@end

@implementation aszSeqWebPageViewController


- (IBAction)dissmisModal:(id)sender {
    
  [[self parentViewController] dismissModalViewControllerAnimated:YES];
    
}

-(void)viewDidLoad{
    self.pageCount.text=self.title;
}


-(void) startLoadingWithTitle:(NSString*)title{
    
    self.title=title;
    
    
    self.dlWebView = [[UIWebView alloc]init];
    
  //  self.dlWebView.scalesPageToFit =YES;
    
    self.dlWebView.multipleTouchEnabled =YES;
    
    [self.view addSubview:self.dlWebView];
    
    self.dlWebView.delegate=self.req[1];
    
    [self.dlWebView loadRequest:self.req[0]];
        
}


-(void) viewWillLayoutSubviews{
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        [self.dlWebView setFrame:CGRectMake(60,50,645,638)];
        
    } else {
        
        [self.dlWebView setFrame:CGRectMake(60,50,645,900)];
        
    }
}

@end
