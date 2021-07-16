//
//  SwipableCardViewContainer.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableViewDelegate.h"
#import "SwipableCardViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SwipeableCardViewDataSource;
@protocol SwipableCardViewDelegate;

@interface SwipableCardViewContainer : UIView

@property (nonatomic, weak, nullable) id<SwipeableCardViewDataSource>dataSource;
@property (nonatomic, weak, nullable) id<SwipableCardViewDelegate>delegate;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
