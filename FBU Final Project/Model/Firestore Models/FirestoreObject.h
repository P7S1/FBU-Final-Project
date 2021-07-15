//
//  FirestoreObject.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//
#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirestoreObject : JSONModel

@property (nonatomic, strong) NSString* uid;

- (instancetype)initWithDict:(NSDictionary *)dictionary;
- (NSString *)getDefaultFirestoreDirectory;


- (void)saveInBackgroundAtDirectory: (NSString*)path withCompletion: (nullable void (^)(NSError *_Nullable error))completion;
- (void)saveInBackgroundAtDefaultDirectoryWithCompletion: (nullable void (^)(NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
