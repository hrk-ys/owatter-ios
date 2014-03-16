//
//  UIImage+Extention.h
//  Pods
//
//  Created by Hiroki Yoshifuji on 2014/03/08.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;
- (void)fillColor:(UIColor *)color rect:(CGRect)rect;

@end
