#import "_OWTTweet.h"

@interface OWTTweet : _OWTTweet {}
// Custom logic goes here.

+ (BOOL)validateContent:(NSString*)content error:(NSError**)error;
+ (BOOL)validateMessage:(NSString*)message error:(NSError**)error;

+ (OWTTweet*)tweetWithId:(NSString*)tweetId;

- (void)setInfoWithDic:(NSDictionary*)dic;

- (BOOL)isOwner;

- (void)sendMessage:(NSString*)message complited:(HYErrorBlock)complited;

- (void)sendThanksWithComplited:(HYErrorBlock)complited;

@end
