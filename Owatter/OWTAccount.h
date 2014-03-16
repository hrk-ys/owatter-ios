//
//  OWTAccount.h
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/16.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const OWTAccountDidFinishLogin;
extern NSString* const OWTAccountDidFinishLogout;

@class FBSession;
@interface OWTAccount : NSObject


@property (nonatomic) NSString* loginHash;
@property (nonatomic) NSString* userId;

+ (OWTAccount*)sharedInstance;
- (BOOL)isLogin;

- (void)loginWithFBSession:(FBSession*)session
                 completed:(HYErrorBlock)completed;
- (void)logout;

@end
