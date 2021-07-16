//
//  ButtonsDelegate.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <Foundation/Foundation.h>
#import "SwipeableCardViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ButtonsDelegate <NSObject>

- (void)scrollToPosition: (PanelButtonPosition)posiiton;
- (void)backToCamerea;
- (void)captuerButtonPressed;

@end

NS_ASSUME_NONNULL_END
