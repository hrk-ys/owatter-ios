//
//  UIAlertView+Extension.h
//  Joker
//
//  Created by Hiroki Yoshifuji on 13/06/13.
//  Copyright (c) 2013年 Hiroki Yoshifuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Extension)

+(void)showMessage:(NSString*)message;
+(void)showTitle:(NSString*)title message:(NSString*)message;

@end
