//
//  NSDictionary+Extention.h
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/12/12.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extention)

-(BOOL)enableValue:(id)key;
-(NSString*)stringForKey:(id)key;
-(NSNumber*)numberForKey:(id)key;
-(NSInteger)integerForKey:(id)key;
-(double)doubleForKey:(id)key;
-(BOOL)boolForKey:(id)key;
-(int64_t)int64ForKey:(id)key;

@end
