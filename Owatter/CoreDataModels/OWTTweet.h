#import "_OWTTweet.h"

@interface OWTTweet : _OWTTweet {}
// Custom logic goes here.

+ (BOOL)validateContent:(NSString*)content error:(NSError**)error;
+ (BOOL)validateMessage:(NSString*)message error:(NSError**)error;

- (void)setInfoWithDic:(NSDictionary*)dic;

@end
