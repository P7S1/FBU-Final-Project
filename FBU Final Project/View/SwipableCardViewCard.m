//
//  SwipableCardViewCard.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import "SwipableCardViewCard.h"
#import "SwipeableCardViewDataSource.h"

@interface SwipableCardViewCard ()<SwipeableCardViewDataSource>

@end

@implementation SwipableCardViewCard

- (SwipableCardViewCard*)cardForItemAtIndex:(NSInteger)index {
    
}

- (NSInteger)numberOfCards {
    return 20;
}

- (UIView *)viewForEmptyCards{
    return nil;
}

@end
