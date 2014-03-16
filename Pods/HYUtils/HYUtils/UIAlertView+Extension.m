//
//  UIAlertView+Extension.m
//  Joker
//
//  Created by Hiroki Yoshifuji on 13/06/13.
//  Copyright (c) 2013年 Hiroki Yoshifuji. All rights reserved.
//

#import "UIAlertView+Extension.h"

@implementation UIAlertView (Extension)

+ (void)showMessage:(NSString *)message
{
    [self showTitle:nil message:message];
}

+ (void)showTitle:(NSString *)title message:(NSString *)message
{
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showTitle:title message:message];
        });
        return;
    }

    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
