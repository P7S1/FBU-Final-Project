//
//  SwipableCardViewDelegate.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <Foundation/Foundation.h>
#import "SwipableCardViewCard.h"
#import "PanelButtonPosition.h"

NS_ASSUME_NONNULL_BEGIN

@class SwipableCardViewCard;

@protocol SwipableCardViewDelegate <NSObject>

- (void)didSelectCard:(SwipableCardViewCard*)card atIndex:(NSInteger)index;
- (void)didSwipeAwayView:(SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction;

@end

NS_ASSUME_NONNULL_END
