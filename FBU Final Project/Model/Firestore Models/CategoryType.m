//
//  CategoryType.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/20/21.
//

#import "CategoryType.h"

@implementation CategoryType

+ (NSArray<NSString *> *)getAllCategories{
    return @[
        @"New Arrivals",
        @"For You",
        @"Trending right now",
        @"Only on Cornerstore",
        @"Best Sellers",
        @"Trending this month"
    ];
}

@end
