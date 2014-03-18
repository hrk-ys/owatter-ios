// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OWTMessage.h instead.

#import <CoreData/CoreData.h>


extern const struct OWTMessageAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *messageId;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *profImagePath;
	__unsafe_unretained NSString *userId;
} OWTMessageAttributes;

extern const struct OWTMessageRelationships {
	__unsafe_unretained NSString *tweet;
} OWTMessageRelationships;

extern const struct OWTMessageFetchedProperties {
} OWTMessageFetchedProperties;

@class OWTTweet;







@interface OWTMessageID : NSManagedObjectID {}
@end

@interface _OWTMessage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OWTMessageID*)objectID;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* messageId;



//- (BOOL)validateMessageId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* profImagePath;



//- (BOOL)validateProfImagePath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userId;



//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) OWTTweet *tweet;

//- (BOOL)validateTweet:(id*)value_ error:(NSError**)error_;





@end

@interface _OWTMessage (CoreDataGeneratedAccessors)

@end

@interface _OWTMessage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;




- (NSString*)primitiveMessageId;
- (void)setPrimitiveMessageId:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveProfImagePath;
- (void)setPrimitiveProfImagePath:(NSString*)value;




- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;





- (OWTTweet*)primitiveTweet;
- (void)setPrimitiveTweet:(OWTTweet*)value;


@end
