//
//  ZoomTransitionController.m
//  Flix
//
//  Created by Keng Fontem on 6/25/21.
//

#import <UIKit/UIKit.h>
#import "ZoomTransitionController.h"
#import "ZoomAnimatorDelegate.h"

@interface ZoomTransitionController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation ZoomTransitionController:NSObject

- (instancetype)init{
    self = [super init];
    if (self) {
        self.animator = [[ZoomAnimator alloc]init];
        self.interactionController = [[ZoomDismissalInteractionController alloc]init];
        self.isInteractive = NO;
    }
    return self;
}


- (void)didPanWith:(UIPanGestureRecognizer *)gestureRecognizer{
    [self.interactionController didPanWith:gestureRecognizer];
}

//MARK:- UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animator.isPresenting = (BOOL*)YES;
    self.animator.fromDelegate = self.fromDelegate;
    self.animator.toDelegate = self.toDelegate;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animator.isPresenting = (BOOL*)NO;
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

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush){
        self.animator.isPresenting = (BOOL*)YES;
        self.animator.fromDelegate = self.fromDelegate;
        self.animator.toDelegate = self.toDelegate;
    }else{
        self.animator.isPresenting =(BOOL*)NO;
        id<ZoomAnimatorDelegate> temp = self.fromDelegate;
        self.animator.fromDelegate = self.toDelegate;
        self.animator.toDelegate = temp;
    }
    
    return self.animator;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (!self.isInteractive){
        return nil;
    }
    
    self.interactionController.animator = self.animator;
    return self.interactionController;
}

@end
