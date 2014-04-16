//
//  OWTTopViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTTopViewController.h"
#import <GADBannerView.h>

@interface OWTTopViewController ()<GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *owatterButton1;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton2;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton3;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton4;
@property (weak, nonatomic) IBOutlet UIView *wrapView;

@property (nonatomic) GADBannerView *adMobView;
@property (nonatomic) BOOL           adMobIsVisible;


@end

@implementation OWTTopViewController

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
    
    [self.wrapView setBorderColor:nil borderWidth:0 cornerRadius:5.0f];
    
    [self setupButton:_owatterButton1 bgColor:[UIColor colorWithRed:0.300 green:0.702 blue:0.839 alpha:1.000]];
    [self setupButton:_owatterButton2 bgColor:[UIColor colorWithRed:0.304 green:0.680 blue:0.290 alpha:1.000]];
    [self setupButton:_owatterButton3 bgColor:[UIColor colorWithRed:0.806 green:0.236 blue:0.245 alpha:1.000]];
    [self setupButton:_owatterButton4 bgColor:[UIColor colorWithRed:0.207 green:0.464 blue:0.745 alpha:1.000]];
    
    self.adMobView                    = [[GADBannerView alloc] init];
    self.adMobView.height             = 0;
    self.adMobView.delegate           = self;
    self.adMobView.adUnitID           = @"ca-app-pub-1525765559709019/5489549743";
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
//    [self.view addSubview:self.adMobView];
}

- (void)setupButton:(UIButton*)button bgColor:(UIColor*)color
{
    [button setBorderColor:nil borderWidth:0 cornerRadius:5.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                     }];
}
@end
