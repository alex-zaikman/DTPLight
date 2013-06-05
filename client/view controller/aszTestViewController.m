//
//  aszTestViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/5/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszTestViewController.h"


@interface aszTestViewController ()


@end

@implementation aszTestViewController

- (IBAction)back:(id)sender {
    
    UIViewController* vc = [self.splitViewController.viewControllers objectAtIndex:1];
    
    
    [vc.navigationController popToRootViewControllerAnimated:YES];
    
   // [self.navigationController popViewControllerAnimated:YES];

     //[popViewControllerAnimated:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
