//
//  OWTRootViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/16.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTRootViewController.h"

@interface OWTRootViewController ()

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic) BOOL hasMainView;
@property (nonatomic) BOOL hasLoginView;
@end

@implementation OWTRootViewController

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
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didFinishLogin:) name:OWTAccountDidFinishLogin object:nil];
    [center addObserver:self selector:@selector(didFinishLogout:) name:OWTAccountDidFinishLogout object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    OWTAccount* account = [OWTAccount sharedInstance];
    if ([identifier isEqualToString:@"loginView"]) {
        self.loginView.hidden = account.isLogin;
        return !account.isLogin;
    }
    if ([identifier isEqualToString:@"mainView"]) {
        return account.isLogin;
    }
    
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"mainView"]) {
        self.hasMainView = YES;
    }
    if ([segue.identifier isEqualToString:@"loginView"]) {
        self.hasLoginView = YES;
    }
}




- (void)didFinishLogin:(NSNotification*)notification
{
    self.loginView.hidden = YES;
    if (self.hasMainView) {
        self.mainView.hidden = NO;
    } else {
        [self performSegueWithIdentifier:@"mainView" sender:nil];
    }
}
- (void)didFinishLogout:(NSNotification*)notification
{
    self.mainView.hidden = YES;
    if (self.hasLoginView) {
        self.loginView.hidden = NO;
    } else {
        [self performSegueWithIdentifier:@"loginView" sender:nil];
    }
}

@end
