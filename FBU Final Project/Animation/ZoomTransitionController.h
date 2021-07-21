//
//  ZoomTransitionController.h
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//
#import <UIKit/UIKit.h>
#import "ZoomAnimatorDelegate.h"
#import "ZoomAnimator.h"

@protocol ZoomAnimatorDelegate;

@interface ZoomTransitionController : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) ZoomAnimator* _Nullable animator;
@property (nonatomic, strong) ZoomDismissalInteractionController* _Nullable interactionController;
@property (nonatomic) BOOL isInteractive;
@property (nonatomic, weak, nullable) id <ZoomAnimatorDelegate> fromDelegate;
@property (nonatomic, weak, nullable) id <ZoomAnimatorDelegate> toDelegate;

-(void) didPanWith: (UIPanGestureRecognizer*_Nonnull) gestureRecognizer;
@end
