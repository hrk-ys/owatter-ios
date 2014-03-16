//
//  LogFormatter.h
//

#import <Foundation/Foundation.h>
#import <DDLog.h>

@interface LogFormatter : NSObject <DDLogFormatter>
{
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
