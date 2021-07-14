//
//  ScrollViewHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "PanelButtonPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScrollViewHelper : NSObject

+ (UIScrollView*)makeScrollView;
+ (UIScrollView*)makeHorizontalScrollViewWithViewControllers: (NSArray<UIViewController*>*) horizontalControllers withParentViewController: (UIViewController*)parent;
+ (UIButton*) makeUIButtonWithSide: (PanelButtonPosition)side;

@end

NS_ASSUME_NONNULL_END
