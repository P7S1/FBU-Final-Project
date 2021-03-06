//
//  PipContainerView.h
//  FBU Final Project
//
//  Created by Keng Fontem on 8/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PipContainerView : UIView

- (instancetype)initWithViewController: (UIViewController*)viewController;

- (void)resetPipPosition;
- (void)setButtonHidden: (bool)hidden;

@end

NS_ASSUME_NONNULL_END
