//
//  aszWebDlViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszWebDlViewController.h"

@interface aszWebDlViewController ()



@end

@implementation aszWebDlViewController

@synthesize data=_data;
@synthesize dlWebView=_dlWebView;
@synthesize master=_master;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       [self.navigationItem setHidesBackButton:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



- (IBAction)goToClasses:(id)sender {


    
    [self performSegueWithIdentifier:@"dummyMaster" sender:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
