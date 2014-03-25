#import "_OWTMessage.h"

@interface OWTMessage : _OWTMessage {}
// Custom logic goes here.

+ (OWTMessage*)messageWithId:(NSString*)messageId;

- (BOOL)isHideUser;
- (void)setInfoWithDic:(NSDictionary*)dic;

@end
