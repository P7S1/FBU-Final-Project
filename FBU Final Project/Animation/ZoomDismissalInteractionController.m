//
//  ZoomDismissalInteractionController.m
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//

#import <UIKit/UIKit.h>
#import "ZoomDismissalInteractionController.h"
#import "ZoomAnimator.h"

@implementation ZoomDismissalInteractionController : NSObject 

- (void)didPanWith:(UIPanGestureRecognizer *)gestureRecognizer{
    ZoomAnimator* animator = self.animator;
    UIImageView* transitionImageView = animator.transitionImageView;
    UIViewController* fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController* toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView* fromReferenceImageView = [animator.fromDelegate refereneImageViewFor:animator];
    UIImageView* toReferenceImageView = [animator.toDelegate refereneImageViewFor:animator];
    CGRect fromReferenceImageViewFrame = self.fromReferceImageViewFrame;
    CGRect toReferenceImageViewFrame = self.toReferenceImageViewFrame;
    
    [fromReferenceImageView setHidden:YES];
    
    double midY = CGRectGetMidY(fromReferenceImageViewFrame);
    double midX = CGRectGetMidX(fromReferenceImageViewFrame);
    CGPoint anchorPoint = CGPointMake(midX, midY);
    CGPoint translatedPoint = [gestureRecognizer translationInView:fromReferenceImageView];
    CGFloat verticalDelta = translatedPoint.y < 0 ? 0 : translatedPoint.y;
    
    CGFloat backgroundAlpha = [self backgroundAlphaFor:fromVC.view withPanningVerticalDelta:&verticalDelta];
    CGFloat scale = [self scaleFor:fromVC.view withPanningVerticalDelta:&verticalDelta];
    fromVC.view.alpha = backgroundAlpha;
    
    transitionImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    CGPoint newCenter = CGPointMake(anchorPoint.x + translatedPoint.x, anchorPoint.y + translatedPoint.y - transitionImageView.frame.size.height * (1-scale) / 2.0);
    transitionImageView.center = newCenter;
    
    [toReferenceImageView setHidden:YES];
    [self.transitionContext updateInteractiveTransition:1-scale];
    
    toVC.tabBarController.tabBar.alpha = 1 - backgroundAlpha;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [gestureRecognizer velocityInView:fromVC.view];
        
        if (velocity.y < 0 || newCenter.y < anchorPoint.y){
            //cancel
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.9
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionTransitionNone animations:^{
                //Animations
                transitionImageView.frame = fromReferenceImageViewFrame;
                fromVC.view.alpha = 0;
                toVC.tabBarController.tabBar.alpha = 0;
            }
                             completion:^(BOOL finished) {
                //Completion Handler
                
                [toReferenceImageView setHidden:NO];
                [fromReferenceImageView setHidden:NO];
                [transitionImageView removeFromSuperview];
                animator.transitionImageView = nil;
                [self.transitionContext cancelInteractiveTransition];
                [self.transitionContext completeTransition:!self.transitionContext];
                [animator.toDelegate transitionDidEndWith:animator];
                [animator.fromDelegate transitionDidEndWith:animator];
                self.transitionContext = nil;
            }];
            return;
        }
        
        //start animation
        CGRect finalTransitionSize = toReferenceImageViewFrame;
        [UIView animateWithDuration:0.25
            delay:0
            options:UIViewAnimationOptionTransitionNone
            animations:^{
                //Animations
                fromVC.view.alpha = 0;
                transitionImageView.frame = finalTransitionSize;
                toVC.tabBarController.tabBar.alpha = 1;
            }
            completion:^(BOOL finished) {
                //Completion
                [transitionImageView removeFromSuperview];
                [toReferenceImageView setHidden:YES];
                [fromReferenceImageView setHidden:YES];
                
                [self.transitionContext finishInteractiveTransition];
                [self.transitionContext completeTransition:!self.transitionContext];
                [animator.toDelegate transitionDidEndWith:animator];
                [animator.fromDelegate transitionDidEndWith:animator];
                self.transitionContext = nil;
        }];
        
    }
}

- (CGFloat)backgroundAlphaFor:(UIView *)view withPanningVerticalDelta:(CGFloat *)verticalDelta{
    CGFloat startingAlpha = 1.0;
    CGFloat finalAlpha = 0.0;
    CGFloat totalAvaliableAlpha = startingAlpha - finalAlpha;
    
    CGFloat maximumDelta = view.bounds.size.height / 4.0;
    CGFloat deltaAsPercentageOfMaximum = MIN(abs(verticalDelta) / maximumDelta, 1.0);
    
    return startingAlpha - (deltaAsPercentageOfMaximum * totalAvaliableAlpha);
}

- (CGFloat)scaleFor:(UIView *)view withPanningVerticalDelta:(CGFloat *)verticalDelta{
    CGFloat startingScale = 1.0;
    CGFloat finalScale = 0.5;
    CGFloat totalAvaliableScale = startingScale - finalScale;
    
    CGFloat maximumDelta = view.bounds.size.height / 2.0;
    CGFloat deltaAsPercentageOfMaxiumum = MIN(abs(verticalDelta)/maximumDelta, 1.0);
    
    return startingScale - (deltaAsPercentageOfMaxiumum * totalAvaliableScale);
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView* containerView = transitionContext.containerView;
    
    ZoomAnimator* animator = self.animator;
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewKey];
    CGRect fromReferenceImageViewFrame = [animator.fromDelegate refereneImageViewFrameInTransitioningViewFor:animator];
    CGRect toRefernceImageViewFrame = [animator.toDelegate refereneImageViewFrameInTransitioningViewFor:animator];
    UIImageView* fromReferenceImageView = [animator.fromDelegate refereneImageViewFor:animator];
    
    [animator.fromDelegate transitionWillStartWith:animator];
    [animator.toDelegate transitionWillStartWith:animator];
    
    self.fromReferceImageViewFrame = fromReferenceImageViewFrame;
    self.toReferenceImageViewFrame = toRefernceImageViewFrame;
    
    UIImage* referenceImage = fromReferenceImageView.image;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    if (animator.transitionImageView == nil){
        UIImageView* transitionImageView = [[UIImageView alloc]initWithImage:referenceImage];
        transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        transitionImageView.clipsToBounds = true;
        transitionImageView.frame = fromReferenceImageViewFrame;
        animator.transitionImageView = transitionImageView;
        [containerView addSubview:transitionImageView];
    }
    
}

@end
