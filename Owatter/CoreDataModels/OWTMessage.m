#import "OWTMessage.h"


@interface OWTMessage ()

// Private interface goes here.

@end


@implementation OWTMessage

// Custom logic goes here.

+ (OWTMessage*)messageWithId:(NSString*)messageId
{
    OWTMessage* message = [OWTMessage findFirstByAttribute:@"messageId" withValue:messageId];
    
    if (!message) {
        message = [OWTMessage createEntity];
    }
    
    return message;
}

- (void)setInfoWithDic:(NSDictionary*)dic
{
    if ([dic enableValue:@"content"])
        self.content       = [dic stringForKey:@"content"];
    if ([dic enableValue:@"message_id"])
        self.messageId     = [dic stringForKey:@"message_id"];
    if ([dic enableValue:@"name"])
        self.name          = [dic stringForKey:@"name"];
    if ([dic enableValue:@"prof_image_path"])
        self.profImagePath = [dic stringForKey:@"prof_image_path"];
    if ([dic enableValue:@"user_id"])
        self.userId        = [dic stringForKey:@"user_id"];
}

@end
