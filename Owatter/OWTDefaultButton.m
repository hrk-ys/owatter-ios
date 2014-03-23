//
//  OWTDefaultButton.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTDefaultButton.h"

@implementation OWTDefaultButton

- (void)awakeFromNib
{
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.877 alpha:1.000]] forState:UIControlStateNormal];
    
    self.layer.cornerRadius = 5.0f;
    [self setClipsToBounds:YES];
}

@end
