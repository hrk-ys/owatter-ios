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
    [self setTitleColor:[UIColor colorWithRed:0.584 green:0.521 blue:0.094 alpha:1.000] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.994 green:0.944 blue:0.378 alpha:1.000]] forState:UIControlStateNormal];
    
    self.layer.cornerRadius = 5.0f;
    [self setClipsToBounds:YES];
}

@end
