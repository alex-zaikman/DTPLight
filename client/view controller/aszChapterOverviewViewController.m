//
//  aszChapterOverviewViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/5/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszChapterOverviewViewController.h"

@interface aszChapterOverviewViewController ()


@property (weak, nonatomic) IBOutlet UITextView *blabla;
@property (nonatomic,strong) NSString *overview;

@end

@implementation aszChapterOverviewViewController

@synthesize blabla=_blabla;
@synthesize overview=_overview;


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
	// Do any additional setup after loading the view.
    self.blabla.text = self.overview;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) set:(NSDictionary*)args{
    
    [self setTitle:(NSString*)[args valueForKey:@"title"]];
    self.overview = [args valueForKey:@"overview"];

 //   self.ovtext.text = ov;
    [self.view setNeedsDisplay];
    
}
@end
