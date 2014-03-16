//
//  JKLogFormatter.m
//

#import "LogFormatter.h"

@implementation LogFormatter

- (id)init
{
    if ((self = [super init]))
    {
        threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [threadUnsafeDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR:
            logLevel = @"[E]";
            break;
            
        case LOG_FLAG_WARN:
            logLevel = @"[W]";
            break;
            
        case LOG_FLAG_INFO:
            logLevel = @"[I]";
            break;
            
        default: logLevel = @"[D]"; break;
    }
    
    NSString *dateAndTime =
    [threadUnsafeDateFormatter stringFromDate:(logMessage->timestamp)];
    
    return [NSString stringWithFormat:@"%@ [%d] %@ %s #%-4d %@",
            dateAndTime,
            logMessage->machThreadID,
            logLevel,
            logMessage->function,
            logMessage->lineNumber,
            logMessage->logMsg
            ];
}

@end
