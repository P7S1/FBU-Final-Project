//
//  SwipableViewDelegate.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableCardViewCard.h"

NS_ASSUME_NONNULL_BEGIN

@class SwipableCardViewCard;

@protocol SwipableViewDelegate <NSObject>

- (void)didTapView: (SwipableCardViewCard*)view;
- (void)didBeginSwipeOnView: (SwipableCardViewCard*)view;
- (void)didEndSwipeOnView: (SwipableCardViewCard*)view;


@end

NS_ASSUME_NONNULL_END
