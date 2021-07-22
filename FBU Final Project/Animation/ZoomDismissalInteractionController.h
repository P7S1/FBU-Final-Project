//
//  ZoomDismissalInteractionController.h
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZoomDismissalInteractionController: NSObject <UIViewControllerInteractiveTransitioning>

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning> animator;

@property (nonatomic) CGRect fromReferceImageViewFrame;
@property (nonatomic) CGRect toReferenceImageViewFrame;

-(void) didPanWith: (UIPanGestureRecognizer*) gestureRecognizer;
-(CGFloat) backgroundAlphaFor: (UIView*)view withPanningVerticalDelta: (CGFloat*)verticalDelta;
-(CGFloat) scaleFor: (UIView*)view withPanningVerticalDelta: (CGFloat*)verticalDelta;

-(void) startInteractiveTransition: (id<UIViewControllerContextTransitioning>) transitionContext;

@end
