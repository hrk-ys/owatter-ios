//
//  OWTCreateReceiveViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/18.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCreateReceiveViewController.h"
#import <GADBannerView.h>

@interface OWTCreateReceiveViewController ()<GADBannerViewDelegate>

@property (nonatomic) GADBannerView *adMobView;
@property (nonatomic) BOOL           adMobIsVisible;

@end

@implementation OWTCreateReceiveViewController

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

    self.adMobView                    = [[GADBannerView alloc] init];
    self.adMobView.height             = 0;
    self.adMobView.delegate           = self;
    self.adMobView.adUnitID           = @"ca-app-pub-1525765559709019/6966282945";
    self.adMobView.rootViewController = self;
    self.adMobView.adSize             = kGADAdSizeSmartBannerPortrait;
    GADRequest *request = [GADRequest request];
#ifdef DEBUG
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           nil];
#endif
    [self.adMobView loadRequest:request];
    self.adMobView.hidden = YES;
    [self.view addSubview:self.adMobView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tappedThanksButton:(UIButton*)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    sender.enabled = YES;
    
    [self.tweet sendThanksWithComplited:^(NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            sender.enabled = NO;
            [error show];
            return;
        }
        SHOW_STATUS(@"Thanksしました");
    }];
}


- (IBAction)tappedClose:(id)sender {
    UIViewController* topViewController
    = self.navigationController.viewControllers[0];

    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [topViewController performSegueWithIdentifier:@"hist" sender:nil];
}


#pragma mark -
#pragma mark admod

- (void)adViewDidReceiveAd:(GADBannerView *)banner
{
    LOGTrace;
    if (self.adMobIsVisible) { return; }
    
    self.adMobIsVisible = YES;
    
    self.adMobView.originY = self.view.height;
    self.adMobView.hidden  = NO;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.adMobView.originY -= self.adMobView.height;
                     } completion:^(BOOL finished) {
                     }];
}

- (void)adView:(GADBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    LOGTrace;
    if (!self.adMobIsVisible) { return; }
    self.adMobIsVisible = NO;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.adMobView.originY = self.view.height;
                     } completion:^(BOOL finished) {
                         self.adMobView.hidden = YES;
                     }];
}

@end
