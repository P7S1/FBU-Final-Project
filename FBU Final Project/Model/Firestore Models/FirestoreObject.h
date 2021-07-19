//
//  FirestoreObject.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

NS_ASSUME_NONNULL_BEGIN

@interface FirestoreObject : NSObject

@property (nonatomic, strong) NSString* uid;

- (instancetype)initWithDict:(NSDictionary *)dictionary;
- (NSString *)getDefaultFirestoreDirectory;

- (void)saveInBackgroundAtDirectory: (NSString*)path withCompletion: (nullable void (^)(NSError *_Nullable error))completion;
- (void)saveInBackgroundAtDefaultDirectoryWithCompletion: (nullable void (^)(NSError *_Nullable error))completion;

+ (NSDictionary*)dictionaryWithPropertiesOfObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
