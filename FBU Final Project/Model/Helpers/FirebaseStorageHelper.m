//
//  FirebaseStorageHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import "FirebaseStorageHelper.h"

@implementation FirebaseStorageHelper

+ (void)saveImageAtStorageReferenceString:(NSString *)referenceString image:(UIImage *)image completionHandler:(StorageCompletionBlock)completion{
    FIRStorageReference * const storageRef = [[FIRStorage storage] reference];
    FIRStorageReference *imageRef = [storageRef child:referenceString];

    NSData *data = UIImageJPEGRepresentation(image, 0.6);

    [imageRef putData:data metadata:nil completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        if (error != nil){
            completion(nil,error);
        }else{
            [imageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                completion(URL,error);
            }];
        }
    }];
}

@end
