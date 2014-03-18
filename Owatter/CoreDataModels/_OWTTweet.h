// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OWTTweet.h instead.

#import <CoreData/CoreData.h>


extern const struct OWTTweetAttributes {
	__unsafe_unretained NSString *canTalk;
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *profImagePath;
	__unsafe_unretained NSString *tweetId;
	__unsafe_unretained NSString *userId;
} OWTTweetAttributes;

extern const struct OWTTweetRelationships {
	__unsafe_unretained NSString *messages;
} OWTTweetRelationships;

extern const struct OWTTweetFetchedProperties {
} OWTTweetFetchedProperties;

@class OWTMessage;









@interface OWTTweetID : NSManagedObjectID {}
@end

@interface _OWTTweet : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OWTTweetID*)objectID;





@property (nonatomic, strong) NSNumber* canTalk;



@property BOOL canTalkValue;
- (BOOL)canTalkValue;
- (void)setCanTalkValue:(BOOL)value_;

//- (BOOL)validateCanTalk:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createdAt;



//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* profImagePath;



//- (BOOL)validateProfImagePath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tweetId;



//- (BOOL)validateTweetId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userId;



//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *messages;

- (NSMutableOrderedSet*)messagesSet;





@end

@interface _OWTTweet (CoreDataGeneratedAccessors)

- (void)addMessages:(NSOrderedSet*)value_;
- (void)removeMessages:(NSOrderedSet*)value_;
- (void)addMessagesObject:(OWTMessage*)value_;
- (void)removeMessagesObject:(OWTMessage*)value_;

@end

@interface _OWTTweet (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCanTalk;
- (void)setPrimitiveCanTalk:(NSNumber*)value;

- (BOOL)primitiveCanTalkValue;
- (void)setPrimitiveCanTalkValue:(BOOL)value_;




- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveProfImagePath;
- (void)setPrimitiveProfImagePath:(NSString*)value;




- (NSString*)primitiveTweetId;
- (void)setPrimitiveTweetId:(NSString*)value;




- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;





- (NSMutableOrderedSet*)primitiveMessages;
- (void)setPrimitiveMessages:(NSMutableOrderedSet*)value;


@end
