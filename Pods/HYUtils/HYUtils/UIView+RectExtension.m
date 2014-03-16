//
//  UIView+RectExtension.m
//

#import "UIView+RectExtension.h"

@implementation UIView (RectExtention)

-(CGFloat)originX
{
    return self.origin.x;
}
-(void)setOriginX:(CGFloat)x
{
    CGPoint origin = self.origin;
    origin.x = x;
    self.origin = origin;
}
-(CGFloat)originY
{
    return self.origin.y;
}
-(void)setOriginY:(CGFloat)y
{
    CGPoint origin = self.origin;
    origin.y = y;
    self.origin = origin;
}

-(CGFloat)centerX
{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)x
{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}
-(CGFloat)centerY
{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)y
{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}

-(CGPoint)origin
{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGFloat)left
{
    return self.frame.origin.x;
}
-(void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

-(CGFloat)right
{
    return (self.frame.origin.x + self.frame.size.width);
}
-(void)setRight:(CGFloat)right
{
    CGFloat diff = self.right - right;
    self.centerX -= diff;
}

-(CGFloat)top
{
    return self.frame.origin.y;
}
-(void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

-(CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setBottom:(CGFloat)bottom
{
    CGFloat diff = self.bottom - bottom;
    self.centerY -= diff;
}

-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
