//
//  NSError+Creator.h
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/18.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Creator)

+ (NSError*)errorWithTitle:(NSString*)title message:(NSString*)message;

@end
