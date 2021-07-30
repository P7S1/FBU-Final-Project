//
//  SwipableCardViewContainer.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableViewDelegate.h"
#import "SwipableCardViewDelegate.h"
#import "PanelButtonPosition.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SwipeableCardViewDataSource;
@protocol SwipableCardViewDelegate;

@interface SwipableCardViewContainer : UIView

@property (nonatomic, weak, nullable) id<SwipeableCardViewDataSource>dataSource;
@property (nonatomic, weak, nullable) id<SwipableCardViewDelegate>delegate;

- (void)reloadData;
- (SwipableCardViewCard*)dequeueReusableCardView;
- (void)dismissCardTowardsDirection: (PanelButtonPosition)direction;

@end

NS_ASSUME_NONNULL_END
