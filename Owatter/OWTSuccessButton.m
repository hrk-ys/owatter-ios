//
//  OWTSuccessButton.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/17.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTSuccessButton.h"

@implementation OWTSuccessButton

- (void)awakeFromNib
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.498 green:0.745 blue:0.871 alpha:1.000]] forState:UIControlStateNormal];
    
    self.layer.cornerRadius = 5.0f;
    [self setClipsToBounds:YES];
}

@end
