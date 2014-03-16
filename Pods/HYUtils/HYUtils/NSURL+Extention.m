//
//  NSURL+Extention.m
//  Joker
//
//  Created by Hiroki Yoshifuji on 13/06/16.
//  Copyright (c) 2013年 Hiroki Yoshifuji. All rights reserved.
//

#import "NSURL+Extention.h"

@implementation NSURL (Extention)

+ (NSString*) uriEncode:(NSString*) str {
	NSString* encoded = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                             kCFAllocatorDefault,
                                                                                             (__bridge CFStringRef)str,
                                                                                             NULL,
                                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                             kCFStringEncodingUTF8));
	return encoded;
}

+ (NSString*) uriDecode:(NSString*) str
{
	str = [str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
	str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return str;
}

+ (NSString*) queryStringFromDictionary:(NSDictionary*) dict {
	NSMutableArray* array = [NSMutableArray array];
	for (NSString* key in [dict allKeys]) {
		NSString* val = [dict objectForKey:key];
		[array addObject:[NSString stringWithFormat:@"%@=%@",
                          [self uriEncode:key],
                          [self uriEncode:val]]];
	}
	return [array componentsJoinedByString:@"&"];
}

+ (NSDictionary*) dictionaryWithQueryString:(NSString*)query
{
	NSMutableDictionary* dict = [NSMutableDictionary dictionary];
	for (NSString* pair in [query componentsSeparatedByString:@"&"]) {
		NSArray* array = [pair componentsSeparatedByString:@"="];
		if ([array count] < 2) {
			continue;
		}
		NSString* key = [self uriDecode:[array objectAtIndex:0]];
		NSString* val = [self uriDecode:[array objectAtIndex:1]];
		
		[dict setObject:val forKey:key];
	}
	return dict;
}

- (NSDictionary*) dictionaryWithQueryString
{
    return [self.class dictionaryWithQueryString:self.query];
}

@end
