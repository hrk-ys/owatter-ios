//
//  HYBlock.h
//

typedef void (^HYBlock)(void);
typedef void (^HYDictionaryBlock)(NSDictionary* dict);
typedef void (^HYArrayBlock)(NSArray* array);
typedef void (^HYBoolBlock)(BOOL success);
typedef void (^HYErrorBlock)(NSError *error);
typedef void (^HYStringBlock)(NSString *str);
typedef void (^HYImageBlock)(UIImage *image);
typedef void (^HYIntegerBlock)(NSInteger integer);