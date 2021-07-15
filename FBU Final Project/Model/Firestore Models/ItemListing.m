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

- (NSString *)getDefaultFirestoreDirectory{
    return [@"listings/" stringByAppendingString:self.uid];
}

@end