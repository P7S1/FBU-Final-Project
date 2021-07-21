//
//  ZoomTransitionController.m
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//

#import <UIKit/UIKit.h>
#import "ZoomTransitionController.h"
#import "ZoomAnimatorDelegate.h"
@interface ZoomTransitionController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ZoomTransitionController:NSObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animator = [[ZoomAnimator alloc]init];
        self.interactionController = [[ZoomDismissalInteractionController alloc]init];
    }
    return self;
}


- (void)didPanWith:(UIPanGestureRecognizer *)gestureRecognizer{
    [self.interactionController didPanWith:gestureRecognizer];
}

//MARK:- UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animator.isPresenting = true;
    self.animator.fromDelegate = self.fromDelegate;
    self.animator.toDelegate = self.toDelegate;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animator.isPresenting = false;
    id<ZoomAnimatorDelegate> tmp = self.fromDelegate;
    self.animator.fromDelegate = self.toDelegate;
    self.animator.toDelegate = tmp;
    return self.animator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    if (!self.isInteractive){
        return nil;
    }
    
    self.interactionController.animator = animator;
    return self.interactionController;
}
@end
