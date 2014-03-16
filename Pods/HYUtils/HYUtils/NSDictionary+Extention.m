//
//  NSDictionary+Extention.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/12/12.
//
//

#import "NSDictionary+Extention.h"

#ifndef DDLogCWarn
    #ifdef  DEBUG
        #define DDLogCWarn NSLog
    #else
        #define DDLogCWarn(...) ((void)0)
    #endif
#endif

@implementation NSDictionary (Extention)

-(BOOL)enableValue:(id)key
{
    if (![self objectForKey:key]) return NO;
    id object = [self objectForKey:key];
    if (!object) return NO;
    if ([object isKindOfClass:[NSNull class]]) return NO;
    return YES;
}

- (NSString*)stringForKey:(id)key
{
    if (![self enableValue:key]) return @"";
    
    id obj = [self objectForKey:key];
    if (!obj) return @"";
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString*)obj;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj stringValue];
    }
    return [obj description];
}

- (NSNumber*)numberForKey:(id)key {
    if (![self enableValue:key]) return @0;
    
    id obj = [self objectForKey:key];
    if (!obj) return @0;
    
    return [NSNumber numberWithDouble: [obj doubleValue]];
}

- (NSInteger)integerForKey:(id)key
{
    NSInteger num = 0;
    
    if (![self enableValue:key]) return num;
    
    id obj = [self objectForKey:key];
    if (!obj) return num;
    
    @try {
        num = [obj integerValue];
    }
    @catch (NSException *exception) {
        DDLogCWarn(@"[WARN] integerForKey failed on dictionary %@ for key %@", self, key);
    }
    return num;
}

- (double)doubleForKey:(id)key
{
    double num = 0;
    
    if (![self enableValue:key]) return num;
    
    id obj = [self objectForKey:key];
    if (!obj) return num;
    
    @try {
        num = [obj doubleValue];
    }
    @catch (NSException *exception) {
        DDLogCWarn(@"[WARN] doubleForKey failed on dictionary %@ for key %@", self, key);
    }
    return num;
}

- (BOOL)boolForKey:(id)key {
    if (![self enableValue:key]) return NO;
    id obj = [self objectForKey:key];
    return [obj boolValue];
}

- (int64_t)int64ForKey:(id)key
{
    int64_t num = 0;
    
    if (![self enableValue:key]) return num;
    
    id obj = [self objectForKey:key];
    if (!obj) return num;
    
    @try {
        num = [obj longLongValue];
    }
    @catch (NSException *exception) {
        DDLogCWarn(@"[WARN] integerForKey failed on dictionary %@ for key %@", self, key);
    }
    return num;
}

@end
