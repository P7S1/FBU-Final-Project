//
//  ZoomDismissalInteractionController.m
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//

#import <UIKit/UIKit.h>
#import "ZoomDismissalInteractionController.h"
#import "ZoomAnimator.h"
#import "CGAffineTransformHelper.h"

@implementation ZoomDismissalInteractionController : NSObject 

- (void)didPanWith:(UIPanGestureRecognizer *)gestureRecognizer{
    ZoomAnimator* animator = self.animator;
    UIImageView* transitionImageView = animator.transitionImageView;
    UIViewController* fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //UIViewController* toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
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
    
    //CGFloat backgroundAlpha = [self backgroundAlphaFor:fromVC.view withPanningVerticalDelta:&verticalDelta];
    CGFloat scale = [self scaleFor:fromVC.view withPanningVerticalDelta:&verticalDelta];
    transitionImageView.layer.cornerRadius = (1-scale) * toReferenceImageView.layer.cornerRadius;
    
    transitionImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    CGPoint newCenter = CGPointMake(anchorPoint.x + translatedPoint.x, anchorPoint.y + translatedPoint.y - transitionImageView.frame.size.height * (1-scale) / 2.0);

    transitionImageView.center = newCenter;
    
    fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    fromVC.view.center = newCenter;
    
    [toReferenceImageView setHidden:YES];
    [self.transitionContext updateInteractiveTransition:1-scale];

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [gestureRecognizer velocityInView:fromVC.view];
        
        if (velocity.y < 0 || newCenter.y < anchorPoint.y){
            //cancel
            UISpringTimingParameters* timingParameters = [[UISpringTimingParameters alloc]initWithDampingRatio:0.7];
            UIViewPropertyAnimator* propertyAnimator = [[UIViewPropertyAnimator alloc]initWithDuration:0.5 timingParameters:timingParameters];
            [propertyAnimator addAnimations:^{
                //Animations
                transitionImageView.frame = fromReferenceImageViewFrame;
                transitionImageView.layer.cornerRadius = fromReferenceImageView.layer.cornerRadius;
                fromVC.view.frame = UIScreen.mainScreen.bounds;
                fromVC.view.transform = CGAffineTransformIdentity;
                fromVC.view.alpha = 1.0;
            }];
            [propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                //Completion Handler
                [toReferenceImageView setHidden:NO];
                [fromReferenceImageView setHidden:NO];
                [transitionImageView removeFromSuperview];
                animator.transitionImageView = nil;
                [self.transitionContext cancelInteractiveTransition];
                [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
                [animator.toDelegate transitionDidEndWith:animator];
                [animator.fromDelegate transitionDidEndWith:animator];
                self.transitionContext = nil;
            }];
            [propertyAnimator startAnimation];
        }else{
            CGRect finalTransitionSize = toReferenceImageViewFrame;
            UISpringTimingParameters* timingParameters = [[UISpringTimingParameters alloc]initWithDampingRatio:0.7];
            UIViewPropertyAnimator* propertyAnimator = [[UIViewPropertyAnimator alloc]initWithDuration:0.5 timingParameters:timingParameters];
            [propertyAnimator addAnimations:^{
                //Animations
                //fromVC.view.alpha = 0;
                fromVC.view.transform = [CGAffineTransformHelper transformFromRect:fromVC.view.frame toRect:finalTransitionSize];
                fromVC.view.alpha = 0.0;
                transitionImageView.frame = finalTransitionSize;
                fromVC.view.layer.shadowColor = UIColor.clearColor.CGColor;
                transitionImageView.layer.cornerRadius = toReferenceImageView.layer.cornerRadius;
            }];
            [propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                //Completion
                [transitionImageView removeFromSuperview];
                [toReferenceImageView setHidden:NO];
                [fromReferenceImageView setHidden:YES];
                
                [self.transitionContext finishInteractiveTransition];
                [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
                [animator.toDelegate transitionDidEndWith:animator];
                [animator.fromDelegate transitionDidEndWith:animator];
                self.transitionContext = nil;
            }];
            [propertyAnimator startAnimation];
        }
    }
}

- (CGFloat)backgroundAlphaFor:(UIView *)view withPanningVerticalDelta:(CGFloat *)verticalDelta{
    CGFloat startingAlpha = 1.0;
    CGFloat finalAlpha = 0.0;
    CGFloat totalAvaliableAlpha = startingAlpha - finalAlpha;
    
    CGFloat maximumDelta = view.bounds.size.height / 4.0;
    CGFloat deltaAsPercentageOfMaximum = MIN(fabs(*verticalDelta) / maximumDelta, 1.0);
    
    return startingAlpha - (deltaAsPercentageOfMaximum * totalAvaliableAlpha);
}

- (CGFloat)scaleFor:(UIView *)view withPanningVerticalDelta:(CGFloat *)verticalDelta{
    CGFloat startingScale = 1.0;
    CGFloat finalScale = 0.7;
    CGFloat totalAvaliableScale = startingScale - finalScale;
    
    CGFloat maximumDelta = view.bounds.size.height / 2.0;
    CGFloat deltaAsPercentageOfMaxiumum = MIN((fabs(*verticalDelta)/maximumDelta), 1.0);
    
    return startingScale - (deltaAsPercentageOfMaxiumum * totalAvaliableScale);
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView* containerView = transitionContext.containerView;
    
    ZoomAnimator* animator = self.animator;
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect fromReferenceImageViewFrame = [animator.fromDelegate refereneImageViewFrameInTransitioningViewFor:animator];
    CGRect toRefernceImageViewFrame = [animator.toDelegate refereneImageViewFrameInTransitioningViewFor:animator];
    UIImageView* fromReferenceImageView = [animator.fromDelegate refereneImageViewFor:animator];
    
    [animator.fromDelegate transitionWillStartWith:animator];
    [animator.toDelegate transitionWillStartWith:animator];
    
    self.fromReferceImageViewFrame = fromReferenceImageViewFrame;
    self.toReferenceImageViewFrame = toRefernceImageViewFrame;
    
    UIImage* referenceImage = fromReferenceImageView.image;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    UIImageView* transitionImageView = [[UIImageView alloc]initWithImage:referenceImage];
    transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImageView.clipsToBounds = true;
    transitionImageView.frame = fromReferenceImageViewFrame;
    animator.transitionImageView = transitionImageView;
    
    [containerView addSubview:transitionImageView];
    
}

- (UIImageView*)getSnapshotImageViewForViewController: (UIViewController*)viewController{
    UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, NO, [UIScreen mainScreen].scale);

    [viewController.view drawViewHierarchyInRect:viewController.view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [[UIImageView alloc]initWithImage:image];
}

@end
