//
//  OWTDataManager.h
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/22.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const OWTDataManagerDidFinishSync;
extern NSString* const OWTDataManagerDidFailureSync;

@interface OWTDataManager : NSObject

+ (OWTDataManager*)sharedInstance;

- (void)syncData;

@end
