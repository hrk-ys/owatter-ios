//
//  OWTLoginViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/16.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTLoginViewController.h"
#import "OWTAppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBLoginViewButtonPNG.h>
#import <FacebookSDK/FBLoginViewButtonPressedPNG.h>

@interface OWTLoginViewController ()
<FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation OWTLoginViewController

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
    
    FBLoginView* loginView = [[FBLoginView alloc] initWithReadPermissions:@[ @"basic_info" ]];
    loginView.center = self.view.center;
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedLoginButton:(id)sender {
    [self login];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [error show];
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    if (FBSessionStateOpen == FBSession.activeSession.state) {
        [self login];
    }
}

- (void)login {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[OWTAccount sharedInstance] loginWithFBSession:FBSession.activeSession
                                          completed:^(NSError *error) {
                                              [SVProgressHUD dismiss];
                                              if (error) {
                                                  [error show];
                                              }
                                          }];

}

@end
