//
//  OWTLoginViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/16.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTLoginViewController.h"
#import "OWTAppDelegate.h"

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <STTwitter/STTwitter.h>

@interface OWTLoginViewController ()<UIActionSheetDelegate>
@property (nonatomic) ACAccountStore *accountStore;
@property (nonatomic) ACAccount* account;
@property (nonatomic) NSArray* accounts;
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
 
     _accountStore = [[ACAccountStore alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginWithToken:(NSDictionary*)token {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[OWTAccount sharedInstance] loginWithToken:token
                                          completed:^(NSError *error) {
                                              [SVProgressHUD dismiss];
                                              if (error) {
                                                  [error show];
                                              }
                                          }];

}


- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}

- (IBAction)tappedLoginButton:(id)sender {
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                              consumerKey:@"srBnYjoP1D3YvladL7tQovqqo"
                                                           consumerSecret:@"bImKBeLRdMi4E3TzEVMZ3vBUjTfVbEvh2flsgVJI70wq1ut5nD"];
    
    [twitter postReverseOAuthTokenRequest:^(NSString *authenticationHeader) {
        
        STTwitterAPI *twitterAPIOS = [STTwitterAPI twitterAPIOSWithFirstAccount];
        
        [twitterAPIOS verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            [twitterAPIOS postReverseAuthAccessTokenWithAuthenticationHeader:authenticationHeader
                                                                successBlock:^(NSString *oAuthToken,
                                                                               NSString *oAuthTokenSecret,
                                                                               NSString *userID,
                                                                               NSString *screenName) {
                                                                    
                                                                    NSDictionary* token = @{
                                                                                            @"token": oAuthToken,
                                                                                            @"token_secret": oAuthTokenSecret,
                                                                                            };
                                                                    
                                                                    [self loginWithToken:token];
                                                                    
                                                                    LOG(@"%@", token);
                                                                } errorBlock:^(NSError *error) {
                                                                    [error show];
                                                                }];
            
        } errorBlock:^(NSError *error) {
            [error show];
        }];
        
    } errorBlock:^(NSError *error) {
        [error show];
    }];
    
}

- (void)loadAccessToken
{
    LOG(@"%@", self.account.username);
    
}

- (IBAction)tappedOpenWeb:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://app.owatter.hrk-ys.net/"]];
}


@end

