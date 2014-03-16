//
//  NSURL+Extention.h
//  Joker
//
//  Created by Hiroki Yoshifuji on 13/06/16.
//  Copyright (c) 2013年 Hiroki Yoshifuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extention)
+ (NSString *)uriEncode:(NSString *)str;
+ (NSString *)uriDecode:(NSString *)str;
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)query;
- (NSDictionary *)dictionaryWithQueryString;
@end
