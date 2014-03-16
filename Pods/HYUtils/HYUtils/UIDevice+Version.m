//
//  UIDevice+Version.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/11/13.
//
//

#import "UIDevice+Version.h"

@implementation UIDevice (Version)

+ (BOOL)isIOS7
{
    return [[UIDevice currentDevice] isIOS7];
}

- (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[self systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    if (iOsVersionMajor == 7)
    {
        return YES;
    }
    
    return NO;
}

+ (CGFloat)iOSVersion
{
    return [[UIDevice currentDevice] iOSVersion];
}

- (CGFloat)iOSVersion
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]);
}

@end
