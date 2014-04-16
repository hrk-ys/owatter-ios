//
//  OWTAppDelegate.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/13.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTAppDelegate.h"
#import "OWTDataManager.h"

#import <GAI.h>

@implementation OWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
#ifdef DEBUG
    [HYLog updateLogLevel:LOG_FLAG_VERBOSE];
#endif
    [HYLog setupLogger];
    
    // CoreData
    [MagicalRecord setupAutoMigratingCoreDataStack];

    // Initialize tracker.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-42236549-6"];

    [self setupAppearance];
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(didFinishLogin:)
                   name:OWTAccountDidFinishLogin
                 object:nil];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    [[OWTDataManager sharedInstance] syncData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSMutableString *tokenId = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",devToken]];
    [tokenId setString:[tokenId stringByReplacingOccurrencesOfString:@" " withString:@""]]; //余計な文字を消す
    [tokenId setString:[tokenId stringByReplacingOccurrencesOfString:@"<" withString:@""]];
    [tokenId setString:[tokenId stringByReplacingOccurrencesOfString:@">" withString:@""]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
#ifdef DEBUG
                                 @"is_debug" : @(1),
#endif
                                 @"token": tokenId
                                 };
    [manager POST:@"http://app.owatter.hrk-ys.net/api/login/token"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {}
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}

- (void)didFinishLogin:(NSNotification*)notification
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge
                                                                           | UIRemoteNotificationTypeSound
                                                                           | UIRemoteNotificationTypeAlert)];

}

- (void)setupAppearance
{
//    [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle *style) {
//        style.textColor = [UIColor colorWithRed:0.059 green:0.386 blue:0.099 alpha:1.000];
//        style.font = [UIFont boldSystemFontOfSize:13.0f];
//        return style;
//    }];
    
    UIColor* naviTinyColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBarTintColor:naviTinyColor];
    [[UINavigationBar appearance] setTintColor:naviTinyColor];
    [[UIBarButtonItem appearance] setTintColor:naviTinyColor];

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.039 alpha:0.800]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: naviTinyColor }];
    
}

@end
