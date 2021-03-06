//
//  ZoomAnimator.m
//  Flix
//
//  Created by Keng Fontem on 6/24/21.
//

#import <UIKit/UIKit.h>
#import "ZoomAnimator.h"
#import "ZoomAnimatorDelegate.h"

@interface ZoomAnimator()<UIViewControllerAnimatedTransitioning>

@end

@implementation ZoomAnimator : NSObject

//MARK:- Zoom In
-(void)animateZoomInTransition: (id<UIViewControllerContextTransitioning>) transitionContext{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIImageView *fromReferenceImageView = [self.fromDelegate refereneImageViewFor:self];
    UIImageView *toReferenceImageView = [self.toDelegate refereneImageViewFor:self];
    
    CGRect fromReferenceImageViewFrame = [self.fromDelegate refereneImageViewFrameInTransitioningViewFor:self];
    CGRect toReferenceImageViewFrame = [self.toDelegate refereneImageViewFrameInTransitioningViewFor:self];
    
    [self.fromDelegate transitionWillStartWith:self];
    [self.toDelegate transitionWillStartWith:self];
    self.transitionImageView.layer.cornerRadius = fromReferenceImageView.layer.cornerRadius;
    toVC.view.alpha = 0;
    [toReferenceImageView setHidden:YES];
    [containerView addSubview:toVC.view];
    
    UIImage *referenceImage = fromReferenceImageView.image;
    
    if (self.transitionImageView == nil){
        UIImageView *transitionImageView =  [[UIImageView alloc]initWithImage:referenceImage];
        transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        transitionImageView.clipsToBounds = YES;
        transitionImageView.frame = fromReferenceImageViewFrame;
        self.transitionImageView = transitionImageView;
        [containerView addSubview:transitionImageView];
    }
    
    [fromReferenceImageView setHidden: YES];
    
    CGRect finalTransitionSize = toReferenceImageViewFrame;
    
    UISpringTimingParameters* timingParameters = [[UISpringTimingParameters alloc]initWithDampingRatio:0.7];
    UIViewPropertyAnimator* propertyAnimator = [[UIViewPropertyAnimator alloc]initWithDuration:[self transitionDuration:transitionContext] timingParameters:timingParameters];
    [propertyAnimator addAnimations:^{
        //Animations
        self.transitionImageView.frame = finalTransitionSize;
        toVC.view.alpha = 1.0;
        self.transitionImageView.layer.cornerRadius = toReferenceImageView.layer.cornerRadius;
    }];
    [propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        //CompletionHandler
        [self.transitionImageView removeFromSuperview];
        [toReferenceImageView setHidden:NO];
        [fromReferenceImageView setHidden:NO];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [self.fromDelegate transitionDidEndWith:self];
        [self.toDelegate transitionDidEndWith:self];
    }];
    [propertyAnimator startAnimation];
}

//MARK:- Zoom Out

- (void)animateZoomOutTransition: (id<UIViewControllerContextTransitioning>) transitionContext{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIImageView *fromReferenceImageView = [self.fromDelegate refereneImageViewFor:self];
    UIImageView *toReferenceImageView = [self.toDelegate refereneImageViewFor:self];
    
    CGRect fromReferenceImageViewFrame = [self.fromDelegate refereneImageViewFrameInTransitioningViewFor:self];
    CGRect toReferenceImageViewFrame = [self.toDelegate refereneImageViewFrameInTransitioningViewFor:self];
    
    [self.fromDelegate transitionWillStartWith:self];
    [self.toDelegate transitionWillStartWith:self];
    
    [toReferenceImageView setHidden:YES];
    
    UIImage *referenceImage = fromReferenceImageView.image;
    
    if (self.transitionImageView == nil){
        UIImageView* transitionImageView = [[UIImageView alloc]initWithImage:referenceImage];
        transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        transitionImageView.clipsToBounds = YES;
        transitionImageView.frame = fromReferenceImageViewFrame;
        self.transitionImageView = transitionImageView;
    }
    self.transitionImageView.layer.cornerRadius = fromReferenceImageView.layer.cornerRadius;
    [containerView addSubview:self.transitionImageView];
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [fromReferenceImageView setHidden:YES];
    
    CGRect finalTransitionSize = toReferenceImageViewFrame;
    
    UISpringTimingParameters* timingParameters = [[UISpringTimingParameters alloc]initWithDampingRatio:0.7];
    UIViewPropertyAnimator* propertyAnimator = [[UIViewPropertyAnimator alloc]initWithDuration:[self transitionDuration:transitionContext] timingParameters:timingParameters];
    [propertyAnimator addAnimations:^{
        //Animations
        fromVC.view.alpha = 0.0;
        self.transitionImageView.frame = finalTransitionSize;
        self.transitionImageView.layer.cornerRadius = toReferenceImageView.layer.cornerRadius;
    }];
    [propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        //Completion
        [self.transitionImageView removeFromSuperview];
        [toReferenceImageView setHidden:NO];
        [fromReferenceImageView setHidden:YES];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

        [self.toDelegate transitionDidEndWith:self];
        [self.fromDelegate transitionDidEndWith:self];
    }];
    [propertyAnimator startAnimation];
}

//MARK:- UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPresenting){
        return 0.5;
    }else{
        return 0.5;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPresenting){
        [self animateZoomInTransition:transitionContext];
    }else{
        [self animateZoomOutTransition:transitionContext];
    }
}
@end
