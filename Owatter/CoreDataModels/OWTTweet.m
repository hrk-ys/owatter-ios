#import "OWTTweet.h"


@interface OWTTweet ()

// Private interface goes here.

@end


@implementation OWTTweet

// Custom logic goes here.

+ (BOOL)validateContent:(NSString*)content error:(NSError**)error
{
    NSString* trimStr = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (trimStr.length == 0) {
        *error = [NSError errorWithTitle:@"入力不備" message:@"メッセージを入力してください"];
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateMessage:(NSString*)message error:(NSError**)error
{
    return [self validateContent:message error:error];
}



- (void)setInfoWithDic:(NSDictionary*)dic
{
    if ([dic enableValue:@"can_talk"])
        self.canTalkValue  = [dic boolForKey:@"can_talk"];
    if ([dic enableValue:@"content"])
        self.content     = [dic stringForKey:@"content"];
    if ([dic enableValue:@"created_at"])
        self.createdAt   = [NSDate dateWithTimeIntervalSince1970:[dic integerForKey:@"created_at"]];
    if ([dic enableValue:@"name"])
        self.name = [dic stringForKey:@"name"];
    if ([dic enableValue:@"prof_image_path"])
        self.profImagePath = [dic stringForKey:@"prof_image_path"];
    if ([dic enableValue:@"tweet_id"])
        self.tweetId        = [dic stringForKey:@"tweet_id"];
    if ([dic enableValue:@"user_id"])
        self.userId        = [dic stringForKey:@"user_id"];
}


@end
