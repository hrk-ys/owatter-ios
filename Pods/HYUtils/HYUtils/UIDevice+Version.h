//
//  UIDevice+Version.h
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/11/13.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (Version)

+ (BOOL)isIOS7;
- (BOOL)isIOS7;

+ (CGFloat)iOSVersion;
- (CGFloat)iOSVersion;

@end
