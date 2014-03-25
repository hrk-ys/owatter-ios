//
//  HYCharacterLabel.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2014/03/24.
//
//

#import "HYCharacterLabel.h"

@implementation HYCharacterLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [self _init];
}

- (void)_init
{
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.font = [UIFont systemFontOfSize:self.bounds.size.height/2];
    self.textAlignment = NSTextAlignmentCenter;
}

- (UIColor*)bgColorWithCharactor:(NSString*)name
{
    NSArray* bgColors = @[
                          [UIColor blackColor],
                          [UIColor darkGrayColor],
                          [UIColor whiteColor],
                          
                          [UIColor colorWithRed:0.341 green:0.654 blue:0.415 alpha:1.000],
                          [UIColor colorWithRed:0.827 green:0.839 blue:0.274 alpha:1.000],
                          [UIColor colorWithRed:0.742 green:0.217 blue:0.237 alpha:1.000],
                          
                          [UIColor colorWithRed:0.239 green:0.377 blue:0.750 alpha:1.000],
                          [UIColor colorWithRed:0.843 green:0.525 blue:0.252 alpha:1.000],
                          [UIColor colorWithRed:0.522 green:0.068 blue:0.755 alpha:1.000],
                          
                          [UIColor brownColor],
                          ];
    
    unichar c = [name characterAtIndex:0];
    return bgColors[ c % bgColors.count ];
}

- (UIColor*)colorWithCharactor:(NSString*)name
{
    NSArray* colors = @[
                        [UIColor whiteColor],
                        [UIColor whiteColor],
                        [UIColor blackColor],
                        
                        [UIColor whiteColor],
                        [UIColor whiteColor],
                        [UIColor whiteColor],
                        
                        [UIColor whiteColor],
                        [UIColor whiteColor],
                        [UIColor whiteColor],
                        
                        [UIColor whiteColor],
                        ];
    
    unichar c = [name characterAtIndex:0];
    return colors[ c % colors.count ];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text && text.length > 0) {
        [self setTextColor:[self colorWithCharactor:text]];
        [self setBackgroundColor:[self bgColorWithCharactor:text]];
    } else {
        [self setTextColor:[UIColor blackColor]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
