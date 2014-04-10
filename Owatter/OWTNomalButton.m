//
//  OWTNomalButton.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/04/10.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTNomalButton.h"

@implementation OWTNomalButton

- (void)awakeFromNib
{
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setBorderColor:[UIColor lightGrayColor] borderWidth:1.0f cornerRadius:5.0f];
}

@end
