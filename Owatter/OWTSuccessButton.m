//
//  OWTSuccessButton.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/17.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTSuccessButton.h"

@implementation OWTSuccessButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.000 green:0.567 blue:0.050 alpha:1.000]] forState:UIControlStateNormal];
    
    self.layer.cornerRadius = 5.0f;
    [self setClipsToBounds:YES];
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
