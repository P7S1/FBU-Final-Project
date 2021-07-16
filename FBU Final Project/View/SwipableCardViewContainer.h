//
//  SwipableCardViewContainer.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SwipeableCardViewDataSource;

@interface SwipableCardViewContainer : UIView

@property (nonatomic, weak, nullable) id<SwipeableCardViewDataSource>dataSource;

@end

NS_ASSUME_NONNULL_END
