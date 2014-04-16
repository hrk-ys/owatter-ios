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

+ (OWTTweet*)tweetWithId:(NSString*)tweetId
{
    OWTTweet* tweet = [OWTTweet findFirstByAttribute:@"tweetId" withValue:tweetId];
    if (!tweet) {
        tweet = [OWTTweet createEntity];
    }
    
    return tweet;
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
    
    if ([dic enableValue:@"messages"]) {
        NSMutableOrderedSet* messages = [NSMutableOrderedSet orderedSet];
        
        for (NSDictionary* row in [dic objectForKey:@"messages"]) {
            NSString* messageId = [row stringForKey:@"message_id"];
            OWTMessage* message = [OWTMessage messageWithId:messageId];
        
            [message setInfoWithDic:row];
            
            [messages addObject:message];
        }
        
        self.messages = messages;
    }
}

- (BOOL)isOwner
{
    return [self.userId isEqualToString:[[OWTAccount sharedInstance] userId]];
}
- (void)sendMessage:(NSString*)message complited:(HYErrorBlock)complited
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"json":@"1",
                                 @"tweet_id": self.tweetId,
                                 @"content":  message,
                                 };
    
    [manager POST:@"http://app.owatter.hrk-ys.net/api/tweet/message"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              if ([responseObject enableValue:@"error_code"]) {
                  
                  if ([responseObject integerForKey:@"error_code"] == 4) {
                      
                      [[OWTAccount sharedInstance] updateSession:^(NSError *error) {
                          if(error) {
                              dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                              [error show];
                              return ;
                          }
                          
                          [self sendMessage:message complited:complited];
                      }];
                      return;
                  }
              }
              
              if ([responseObject enableValue:@"error_message"]) {
                  dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                  NSError* error = [NSError errorWithTitle:@"" message:responseObject[@"error_message"]];
                  complited(error);
                  return;
              }
              
              OWTMessage* message = [OWTMessage createInContext:self.managedObjectContext];
              [message setInfoWithDic:responseObject[@"message"]];
              
              NSMutableOrderedSet* messages = self.messagesSet;
              
              
              [messages addObject:message];
              
              [self.managedObjectContext saveToPersistentStoreAndWait];
              
              complited(nil);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              complited(error);
          }];

}

- (void)sendThanksWithComplited:(HYErrorBlock)complited
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"json":@"1",
                                 @"tweet_id": self.tweetId,
                                 };
    
    [manager POST:@"http://app.owatter.hrk-ys.net/api/tweet/thanks"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              if ([responseObject enableValue:@"error_code"]) {
            
                  if ([responseObject integerForKey:@"error_code"] == 4) {
                
                      [[OWTAccount sharedInstance] updateSession:^(NSError *error) {
                          if(error) {
                              dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                              [error show];
                              return ;
                          }
                    
                          [self sendThanksWithComplited:complited];
                      }];
                      return;
                  }
              }
              
              if ([responseObject enableValue:@"error_message"]) {
                  dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                  NSError* error = [NSError errorWithTitle:@"" message:responseObject[@"error_message"]];
                  complited(error);
                  return;
              }
              
              OWTMessage* message = [OWTMessage createInContext:self.managedObjectContext];
              [message setInfoWithDic:responseObject[@"message"]];
              
              NSMutableOrderedSet* messages = self.messagesSet;
              
              
              [messages addObject:message];
              
              [self.managedObjectContext saveToPersistentStoreAndWait];
        
              complited(nil);
        
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              complited(error);
          }];
    
}

@end
