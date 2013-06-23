//
//  aszWebDlViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/6/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszWebDlViewController.h"

@interface aszWebDlViewController ()



@property (weak, nonatomic) IBOutlet UINavigationItem *tooBar;


@end

@implementation aszWebDlViewController

@synthesize data=_data;
@synthesize dlWebView=_dlWebView;
@synthesize masterPop=_masterPop;
@synthesize tooBar=_toolBar;
@synthesize backdelegate=_backdelegate;



- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
       // [self.navigationItem setHidesBackButton:YES];
        
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
   
}



- (IBAction)goToClasses:(id)sender {

    self.splitViewController.delegate = self.backdelegate;
    
    [self performSegueWithIdentifier:@"dummyMaster" sender:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title=@"master";
    self.tooBar.rightBarButtonItem = barButtonItem;
    self.masterPop=pc;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{

    self.tooBar.rightBarButtonItem = nil;
    self.masterPop=nil;
}

@end
