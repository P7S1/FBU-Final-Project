//
//  FirestoreObject.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <Foundation/Foundation.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import "FirestoreObject.h"

@interface FirestoreObject ()

@end

@implementation FirestoreObject

- (instancetype)init
{
    self = [super init];
    return self;
}

- (NSString *)getDefaultFirestoreDirectory {
    return @"unknown";
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

- (void) saveInBackgroundAtDirectory: (NSString*)path withCompletion: (nullable void (^)(NSError *_Nullable error))completion{
    FIRDocumentReference* docRef = [[FIRFirestore firestore] documentWithPath:path];
    [docRef setData:self.toDictionary merge:YES completion:completion];
}

- (void) saveInBackgroundAtDefaultDirectoryWithCompletion: (nullable void (^)(NSError *_Nullable error))completion{
    [self saveInBackgroundAtDirectory:[self getDefaultFirestoreDirectory] withCompletion:completion];
}

@end
