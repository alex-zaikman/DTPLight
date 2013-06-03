//
//  aszLoginViewController.m
//  DTPLight
//
//  Created by alex zaikman on 6/2/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszLoginViewController.h"
#import "aszLogin.h"
#import "aszJsonDictionarryManip.h"

#import "aszHttpConnectionHandler.h"

@interface aszLoginViewController ()

-(void) viewNeedsUpdate;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progrees;

@property (weak, nonatomic) IBOutlet UITextView *debug;

@property (weak, nonatomic) IBOutlet UIButton *loginIB;

@property (weak, nonatomic) IBOutlet UIButton *logoutIB;

@property (assign,nonatomic) BOOL loggedin;

@property (strong,nonatomic) NSDictionary *data;

@property (strong,nonatomic) aszLogin *loggin;

@end

@implementation aszLoginViewController

@synthesize userName=_userName;
@synthesize password=_password;
@synthesize progrees=_progrees;
@synthesize loginIB=_loginIB;
@synthesize logoutIB=_logoutIB;
@synthesize loggedin=_loggedin;
@synthesize debug=_debug;
@synthesize data=_data;
@synthesize loggin=_loggin;

-(void) viewNeedsUpdate{
    
    if(self.loggedin==YES){
        [self.logoutIB setEnabled:YES];
        [self.loginIB setEnabled:NO];
        
        [self.userName setEnabled:NO];
        [self.password setEnabled:NO];
    }else{
        [self.logoutIB setEnabled:NO];
        [self.loginIB setEnabled:YES];
        [self.userName setEnabled:YES];
        [self.password setEnabled:YES];
    }
    [self.view setNeedsDisplay];

}
- (IBAction)login:(id)sender {


 
    
    if(!self.loggin)
         self.loggin = [[aszLogin alloc]init];
    
    
    [self.progrees startAnimating];
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
   
    [self.loggin LogInTo:domain asUser:self.userName.text withPassword:self.password.text onSuccessCall:^(NSData *d) {
     
        self.debug.text =@"you are logged in";//[[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
        [self.progrees stopAnimating];
        self.loggedin=YES;
        [self viewNeedsUpdate];
        
    } onFailureCall:^(NSError *e){
        self.debug.text = [e localizedDescription];
        [self.progrees stopAnimating];
        self.loggedin=NO;
        [self viewNeedsUpdate];
    }];
    
    [self viewNeedsUpdate];
    
}



- (IBAction)logout:(id)sender {
    if(self.loggin &&  self.loggedin==YES){
        
        NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
        [self.loggin logoutFrom:domain onSuccessCall:^(NSData *d) {
             self.debug.text =@"you are logged out \n please login ";
             self.loggedin=NO;
            [self viewNeedsUpdate];
        } onFailureCall:^(NSError *e) {
            self.debug.text = [e localizedDescription];
            
        }];
         }
//    self.loggedin=NO;
//    [self viewNeedsUpdate];
}






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loggedin=NO;
        [self viewNeedsUpdate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self viewNeedsUpdate];
}


@end
