//
//  ZoomAnimator.h
//  Flix
//
//  Created by Keng Fontem on 6/24/21.
//
#import <UIKit/UIKit.h>
#import "ZoomAnimatorDelegate.h"

@protocol ZoomAnimatorDelegate;

@interface ZoomAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) id <ZoomAnimatorDelegate> fromDelegate;
@property (nonatomic, weak) id <ZoomAnimatorDelegate> toDelegate;

@property (nonatomic, strong) UIImageView* transitionImageView;
@property (nonatomic) bool* isPresenting;

-(UIImageView*) referenceImageViewFor: (ZoomAnimator*)zoomAnimator;
-(CGRect*) referenceImageViewFrameInTransitioningView: (ZoomAnimator*)zoomAnimator;

@end
