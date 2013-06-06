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
    
    
    UIViewController* vc = [self.splitViewController.viewControllers lastObject];
    
    
    [vc.navigationController popToRootViewControllerAnimated:YES];
    
    //[vc.navigationController popViewControllerAnimated:YES];
   // [[self.splitViewController.viewControllers objectAtIndex:0] popViewControllerAnimated:YES];

     // [self.navigationController popViewControllerAnimated:YES];
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



@end
