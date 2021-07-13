//
//  User.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "FirestoreObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface User : FirestoreObject

//User Singleton
+ (User*) sharedInstance;

+ (void) resetSharedInstance;
+ (void) setSharedInstance: (User*) user;

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSURL * _Nullable profileUrl;

@end

NS_ASSUME_NONNULL_END
