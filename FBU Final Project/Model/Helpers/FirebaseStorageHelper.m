//
//  FirebaseStorageHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import "FirebaseStorageHelper.h"

@implementation FirebaseStorageHelper

+ (void)saveImageAtStorageReferenceString: (NSString *)referenceString image: (UIImage*)image{
    FIRStorageReference * const storageRef = [[FIRStorage storage] reference];
    FIRStorageReference *imageRef = [storageRef child:referenceString];
    
    NSData *data = NSData* data = UIImageJPEGRepresentation(image, 0.6);
    
}

@end
