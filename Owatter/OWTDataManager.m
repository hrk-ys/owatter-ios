//
//  OWTDataManager.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/22.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTDataManager.h"

NSString* const OWTDataManagerDidFinishSync  = @"OWTDataManagerDidFinishSync";
NSString* const OWTDataManagerDidFailureSync = @"OWTDataManagerDidFailureSync";


@interface OWTDataManager()

@property (nonatomic) BOOL isProcess;
@property (nonatomic) NSInteger lastSyncTime;

@end


@implementation OWTDataManager

+ (OWTDataManager*)sharedInstance
{
    static OWTDataManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [OWTDataManager new];
    });
    return instance;
}

- (void)setLastSyncTime:(NSInteger)lastSyncTime
{
    [[NSUserDefaults standardUserDefaults] setInteger:lastSyncTime forKey:@"kOWTDataManager_lastSyncTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)lastSyncTime
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"kOWTDataManager_lastSyncTime"];
}


- (void)syncData {
    
    if (self.isProcess) {
        return;
    }
    
    self.isProcess = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"json":@"1",
                                 @"last_sync_time": @(self.lastSyncTime),
                                 };
    
    [manager POST:@"http://owatter.hrk-ys.net/data_sync"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
              
              self.isProcess = NO;
              
              NSLog(@"JSON: %@", responseObject);
              if ([responseObject enableValue:@"error_code"]) {
                  
                  if ([responseObject integerForKey:@"error_code"] == 4) {
                      
                      [[OWTAccount sharedInstance] updateSession:^(NSError *error) {
                          
                          if(error) {
                              
                              [[NSNotificationCenter defaultCenter] postNotificationName:OWTDataManagerDidFailureSync object:self userInfo:@{ @"error" : error }];
                              
                              return;
                          }
                          
                          [self syncData];
                      }];
                      return;
                  }
              }
              
              if ([responseObject enableValue:@"error_message"]) {
                  
                  NSError* error = [NSError errorWithTitle:@"" message:responseObject[@"error_message"]];
                  
                  [[NSNotificationCenter defaultCenter] postNotificationName:OWTDataManagerDidFailureSync object:self userInfo:@{ @"error" : error }];
                  
                  return;
              }
              
              
              if ([responseObject enableValue:@"tweets"]) {
                  for (NSDictionary* row in responseObject[@"tweets"]
                       ) {
                      
                      NSString* tweetId = [row stringForKey:@"tweet_id"];
                      
                      OWTTweet* tweet = [OWTTweet tweetWithId:tweetId];
                      
                      [tweet setInfoWithDic:row];
                  }
                  
                  [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
              }
              
              [[NSNotificationCenter defaultCenter] postNotificationName:OWTDataManagerDidFailureSync object:self userInfo:@{}];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              self.isProcess = NO;
              
              [[NSNotificationCenter defaultCenter] postNotificationName:OWTDataManagerDidFailureSync object:self userInfo:@{ @"error" : error }];
              
          }];
    
    
    
    
    
}


@end
