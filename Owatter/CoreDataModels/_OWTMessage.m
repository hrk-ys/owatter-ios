// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OWTMessage.m instead.

#import "_OWTMessage.h"

const struct OWTMessageAttributes OWTMessageAttributes = {
	.content = @"content",
	.messageId = @"messageId",
	.name = @"name",
	.profImagePath = @"profImagePath",
	.userId = @"userId",
};

const struct OWTMessageRelationships OWTMessageRelationships = {
	.tweet = @"tweet",
};

const struct OWTMessageFetchedProperties OWTMessageFetchedProperties = {
};

@implementation OWTMessageID
@end

@implementation _OWTMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Message";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Message" inManagedObjectContext:moc_];
}

- (OWTMessageID*)objectID {
	return (OWTMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;






@dynamic messageId;






@dynamic name;






@dynamic profImagePath;






@dynamic userId;






@dynamic tweet;

	






@end
