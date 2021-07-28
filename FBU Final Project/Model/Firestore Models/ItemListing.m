//
//  ItemListing.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import <Foundation/Foundation.h>
#import "ItemListing.h"

@implementation ItemListing

@synthesize description;

- (instancetype)initWithDict:(NSDictionary *)dictionary{
    self = [super initWithDict:dictionary];
    if (self){
        [self commonInit];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    if (self.buyers == nil){
        self.buyers = [[NSArray alloc]init];
    }
}

- (NSString *)getDefaultFirestoreDirectory{
    return [@"listings/" stringByAppendingString:self.uid];
}

@end
