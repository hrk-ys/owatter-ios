#import "_OWTMessage.h"

@interface OWTMessage : _OWTMessage {}
// Custom logic goes here.

+ (OWTMessage*)messageWithId:(NSString*)messageId;

- (void)setInfoWithDic:(NSDictionary*)dic;

@end
