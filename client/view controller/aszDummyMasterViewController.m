//
//  aszDummyMasterViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDummyMasterViewController.h"

@interface aszDummyMasterViewController ()

@end

@implementation aszDummyMasterViewController

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        
    }
    return self;
    
}

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



@end
