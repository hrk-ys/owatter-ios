//
//  OWTAccount.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/16.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTAccount.h"

#import <SSKeychain.h>

NSString* const OWTAccountDidFinishLogin  = @"OWTAccountDidFinishLogin";
NSString* const OWTAccountDidFinishLogout = @"OWTAccountDidFinishLogout";

@implementation OWTAccount

+ (OWTAccount*)sharedInstance
{
    static OWTAccount* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    self.userId = [ud objectForKey:@"kAccountUserId"];
    
    self.loginHash = [SSKeychain passwordForService:@"loginHash" account:@"account"];
}

- (void)saveData
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if (self.userId) {
        [ud setObject:self.userId forKey:@"kAccountUserId"];
        if (self.loginHash)
            [SSKeychain setPassword:self.loginHash forService:@"loginHash" account:@"account"];
    } else {
        [ud removeObjectForKey:@"kAccountUserId"];
        [SSKeychain deletePasswordForService:@"loginHash" account:@"account"];
    }
    [ud synchronize];
}

- (BOOL)isLogin
{
    return self.userId ? YES : NO;
}


- (void)loginWithToken:(NSDictionary *)token
             completed:(HYErrorBlock)completed
{
    LOG(@"token:%@", token);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = token;
        [manager POST:@"http://app.owatter.hrk-ys.net/api/login/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            if (![responseObject enableValue:@"user_id"]) {
                completed([NSError errorWithDomain:@"net.hrk-ys.Owatter" code:1 userInfo:@{}]);
                return;
            }

            self.userId = [responseObject stringForKey:@"user_id"];
            self.loginHash = [responseObject stringForKey:@"login_hash"];
            [self saveData];
            
            completed(nil);
            [[NSNotificationCenter defaultCenter] postNotificationName:OWTAccountDidFinishLogin object:self];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            completed(error);
            NSLog(@"Error: %@", error);
        }];
        
    });
}

- (void)logout
{
    self.userId = nil;
    self.loginHash = nil;
    [self saveData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OWTAccountDidFinishLogout object:self];
}

- (void)updateSession:(HYErrorBlock)completed
{
    if (!self.loginHash) {
        completed([NSError errorWithTitle:@"認証エラー" message:@"認証状態が解除されました。再度ログインしてください"]);
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"login_hash": self.loginHash};
    [manager POST:@"http://app.owatter.hrk-ys.net/api/login/update_session"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {

              if ([responseObject enableValue:@"ok"]) {
                  completed(nil);
                  [[NSNotificationCenter defaultCenter] postNotificationName:OWTAccountDidFinishLogin object:self];

              } else {
                  completed([NSError errorWithTitle:@"認証エラー" message:@"認証状態が解除されました。再度ログインしてください"]);
                  [self logout];
              }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completed(error);
    }];
}

@end
