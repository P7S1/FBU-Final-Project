//
//  SwipeableCardViewDataSource.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <Foundation/Foundation.h>
#import "SwipableCardViewCard.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SwipeableCardViewDataSource <NSObject>

- (NSInteger)numberOfCards;
- (SwipableCardViewCard*)cardForItemAtIndex: (NSInteger)index;
- (UIView * _Nullable)viewForEmptyCards;

@end

NS_ASSUME_NONNULL_END
