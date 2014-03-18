//
//  NSError+Creator.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/18.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "NSError+Creator.h"

@implementation NSError (Creator)

+ (NSError*)errorWithTitle:(NSString*)title message:(NSString*)message
{
    return [NSError errorWithDomain:@"net.hrk-ys.Owatter"
                               code:1
                           userInfo:@{
                                      NSLocalizedFailureReasonErrorKey : message,
                                      NSLocalizedDescriptionKey: title }];
}
@end
