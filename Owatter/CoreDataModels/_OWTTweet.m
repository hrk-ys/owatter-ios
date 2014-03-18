// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OWTTweet.m instead.

#import "_OWTTweet.h"

const struct OWTTweetAttributes OWTTweetAttributes = {
	.canTalk = @"canTalk",
	.content = @"content",
	.createdAt = @"createdAt",
	.name = @"name",
	.profImagePath = @"profImagePath",
	.tweetId = @"tweetId",
	.userId = @"userId",
};

const struct OWTTweetRelationships OWTTweetRelationships = {
	.messages = @"messages",
};

const struct OWTTweetFetchedProperties OWTTweetFetchedProperties = {
};

@implementation OWTTweetID
@end

@implementation _OWTTweet

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tweet";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:moc_];
}

- (OWTTweetID*)objectID {
	return (OWTTweetID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"canTalkValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"canTalk"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic canTalk;



- (BOOL)canTalkValue {
	NSNumber *result = [self canTalk];
	return [result boolValue];
}

- (void)setCanTalkValue:(BOOL)value_ {
	[self setCanTalk:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCanTalkValue {
	NSNumber *result = [self primitiveCanTalk];
	return [result boolValue];
}

- (void)setPrimitiveCanTalkValue:(BOOL)value_ {
	[self setPrimitiveCanTalk:[NSNumber numberWithBool:value_]];
}





@dynamic content;






@dynamic createdAt;






@dynamic name;






@dynamic profImagePath;






@dynamic tweetId;






@dynamic userId;






@dynamic messages;

	
- (NSMutableOrderedSet*)messagesSet {
	[self willAccessValueForKey:@"messages"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"messages"];
  
	[self didAccessValueForKey:@"messages"];
	return result;
}
	






@end
