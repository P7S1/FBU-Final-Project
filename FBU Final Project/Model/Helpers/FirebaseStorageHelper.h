//
//  FirebaseStorageHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseStorage/FirebaseStorage.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirebaseStorageHelper : NSObject

typedef void(^StorageCompletionBlock)(NSURL * _Nullable url, NSError * _Nullable error);
+ (void) saveImageAtStorageReferenceString: (NSString*)referenceString image: (UIImage*)image completionHandler: (StorageCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
