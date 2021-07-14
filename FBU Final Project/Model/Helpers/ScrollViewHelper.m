//
//  ScrollViewHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "ScrollViewHelper.h"
#import "PanelButtonPosition.h"

@implementation ScrollViewHelper

+ (UIScrollView*)makeScrollView{
    UIScrollView* scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = UIColor.clearColor;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}

+ (UIScrollView*)makeHorizontalScrollViewWithViewControllers: (NSArray<UIViewController*>*) horizontalControllers withParentViewController: (UIViewController*)parent{
    UIScrollView* scrollView = [ScrollViewHelper makeScrollView];
    
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    
    for (int i = 0; i < horizontalControllers.count; i++){
        CGFloat xPosition = i * width;
        UIViewController* child = horizontalControllers[i];
        
        [parent addChildViewController:child];
        [scrollView addSubview:child.view];
        [child didMoveToParentViewController:parent];
        
        child.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
            [child.view.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor],
            [child.view.heightAnchor constraintEqualToAnchor:scrollView.heightAnchor],
            [child.view.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor constant:xPosition]
        ]];
    }
    
    scrollView.contentSize = CGSizeMake(width * horizontalControllers.count, height);
    [scrollView setContentOffset:CGPointMake(UIScreen.mainScreen.bounds.size.width, 0)];
    
    return scrollView;
}

+ (UIButton*) makeUIButtonWithSide: (PanelButtonPosition)side {
    
    CGFloat const centralButtonHeight = 70;
    CGFloat const sideButtonHeight = 42;
    
    UIButton* button = [[UIButton alloc]init];
    button.layer.borderWidth = 3;
    button.layer.borderColor = UIColor.whiteColor.CGColor;
    button.layer.cornerRadius = sideButtonHeight/2;
    
    [button.layer setShadowOffset:CGSizeMake(5, 5)];
    [button.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [button.layer setShadowOpacity:0.5];
    
    CGFloat buttonHeight;
    
    switch (side) {
        case center:
            //Center button
            button.layer.cornerRadius = centralButtonHeight/2;
            buttonHeight = centralButtonHeight;
            break;
        default:
            //one of the side buttons
            button.layer.cornerRadius = sideButtonHeight/2;
            buttonHeight = sideButtonHeight;
            break;
    }
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:buttonHeight],
        [button.widthAnchor constraintEqualToConstant:buttonHeight]
    ]];
    
    return button;
}


@end
