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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToClasses:(id)sender {

    
    
    [self performSegueWithIdentifier:@"dummyMaster" sender:self];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
