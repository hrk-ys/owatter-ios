//
//  UIImage+Extention.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2014/03/08.
//
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color rect:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect
{
    UIImage *image = [[UIImage alloc] init];
    [image fillColor:color rect:rect];
    
    return image;
}

- (void)fillColor:(UIColor *)color
             rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [self drawAtPoint:CGPointZero];
    [self drawInRect:rect];
    [color setFill];
    UIRectFill(rect);
    id result = [self initWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage];
    UIGraphicsEndImageContext();
    if (!result) { NSLog(@"failed in the initializetion of the image."); }
}

@end
