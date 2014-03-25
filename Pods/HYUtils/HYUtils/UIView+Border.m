//
//  UIView+Border.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)setBorderColor:(UIColor*)color
           borderWidth:(float)borderWith
          cornerRadius:(float)cornerRadius
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWith;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

@end
