//
//  HYLog.h
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/11/17.
//
//

#import <Foundation/Foundation.h>

extern int ddLogLevel;

#define kLogLevel @ "kLogLevel"

@interface HYLog : NSObject
+ (void) setupLogger;
+ (void) updateLogLevel:(int)logLevel;
@end
