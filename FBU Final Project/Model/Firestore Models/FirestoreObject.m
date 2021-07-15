//
//  FirestoreObject.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <Foundation/Foundation.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import "FirestoreObject.h"
#import <objc/runtime.h>

@interface FirestoreObject ()

@end

@implementation FirestoreObject

- (instancetype)init{
    self = [super init];
    FIRDocumentReference* dummyDoc = [[[FIRFirestore firestore] collectionWithPath:@"dummy"] documentWithAutoID];
    self.uid = dummyDoc.documentID;
    return self;
}

- (NSString *)getDefaultFirestoreDirectory{
    return @"unknown";
}

- (instancetype)initWithDict:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        FIRDocumentReference* dummyDoc = [[[FIRFirestore firestore] collectionWithPath:@"dummy"] documentWithAutoID];
        self.uid = dummyDoc.documentID;
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

- (void)saveInBackgroundAtDirectory: (NSString*)path withCompletion: (nullable void (^)(NSError *_Nullable error))completion{
    FIRDocumentReference* docRef = [[FIRFirestore firestore] documentWithPath:path];
    [docRef setData:[FirestoreObject dictionaryWithPropertiesOfObject:self] merge:YES completion:completion];
    
}

- (void)saveInBackgroundAtDefaultDirectoryWithCompletion: (nullable void (^)(NSError *_Nullable error))completion{
    [self saveInBackgroundAtDirectory:[self getDefaultFirestoreDirectory] withCompletion:completion];
}

+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

      unsigned count;
      objc_property_t *properties = class_copyPropertyList([obj class], &count);

      for (int i = 0; i < count; i++) {
          NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
          Class classObject = NSClassFromString([key capitalizedString]);
          if (classObject) {
            id subObj = [self dictionaryWithPropertiesOfObject:[obj valueForKey:key]];
            [dict setObject:subObj forKey:key];
          }
          else
          {
            id value = [obj valueForKey:key];
            if(value) [dict setObject:value forKey:key];
          }
       }

       free(properties);

       return [NSDictionary dictionaryWithDictionary:dict];
}

@end
