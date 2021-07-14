//
//  ViewControllerHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "ViewControllerHelper.h"

@implementation ViewControllerHelper

+ (void) addChildVcToParentVc: (UIViewController*)parent childVc: (UIViewController*)childVc containerView: (UIView*)containerView{
    if (childVc.view == nil) { return; }
    [parent addChildViewController:childVc];
    [containerView addSubview:childVc.view];
    [childVc didMoveToParentViewController:parent];
    
    childVc.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [childVc.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [childVc.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
        [childVc.view.rightAnchor constraintEqualToAnchor:containerView.rightAnchor],
        [childVc.view.leftAnchor constraintEqualToAnchor:containerView.leftAnchor]
    ]];
    
    containerView.clipsToBounds = YES;
}

@end
