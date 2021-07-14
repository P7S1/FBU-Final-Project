//
//  ScrollViewHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "ScrollViewHelper.h"

@implementation ScrollViewHelper

+ (UIScrollView*)make{
    UIScrollView* scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = UIColor.clearColor;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}

+ (UIScrollView*)makeHorizontalScrollViewWithViewControllers: (NSArray<UIViewController*>*) horizontalControllers withParentViewController: (UIViewController*)parent{
    UIScrollView* scrollView = [ScrollViewHelper make];
    
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


@end
