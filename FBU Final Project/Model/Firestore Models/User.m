//
//  User.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

static User * _Nullable sharedInstance = nil;

+ (User *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[User alloc] init];
    }
    return sharedInstance;
}

- (NSString *)getDefaultFirestoreDirectory{
    return [@"users/" stringByAppendingString:self.uid];
}

+ (void)resetSharedInstance{
    sharedInstance = nil;
}

+ (void)setSharedInstance: (User*) user{
    [User resetSharedInstance];
    sharedInstance = user;
}

@end

