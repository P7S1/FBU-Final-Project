//
//  ButtonsViewController.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "PanelButtonPosition.h"
#import "ButtonsDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonsViewController : UIViewController

@property (nonatomic, weak) id<ButtonsDelegate> delegate;
@property (nonatomic) PanelButtonPosition currentViewControllerPosition;

- (void) animateButtonsWithOffset: (CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
