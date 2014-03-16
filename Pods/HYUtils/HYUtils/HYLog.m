//
//  HYLog.m
//  Pods
//
//  Created by Hiroki Yoshifuji on 2013/11/17.
//
//

#import "HYLog.h"

#import "LogFormatter.h"

#import <DDTTYLogger.h>
#import <DDFileLogger.h>
#import <DDASLLogger.h>

int ddLogLevel = LOG_LEVEL_OFF;

@implementation HYLog

+ (void)setupLogger
{
    ddLogLevel = [[NSUserDefaults standardUserDefaults] integerForKey:kLogLevel];

    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency                       = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [fileLogger setLogFormatter:[[LogFormatter alloc] init]];
    [DDLog addLogger:fileLogger];
    
    DDTTYLogger *logger = [DDTTYLogger sharedInstance];
    [logger setLogFormatter:[[LogFormatter alloc] init]];
    [logger setColorsEnabled:YES];
    [logger setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:
     LOG_FLAG_ERROR];
    [logger setForegroundColor:[UIColor orangeColor] backgroundColor:nil forFlag:
     LOG_FLAG_WARN];
    [logger setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:
     LOG_FLAG_INFO];
    
    [DDLog addLogger:logger];
    
    
    DDASLLogger* aslLogger = [[DDASLLogger alloc] init];
    [aslLogger setLogFormatter:[[LogFormatter alloc] init]];
    [DDLog addLogger:aslLogger];
}


+ (void) updateLogLevel:(int)logLevel
{
    ddLogLevel = logLevel;
    [[NSUserDefaults standardUserDefaults] setInteger:ddLogLevel forKey:kLogLevel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
