//
//  ZoomAnimatorDelegate.h
//  Flix
//
//  Created by Keng Fontem on 6/24/21.
//

#import <Foundation/Foundation.h>
#import "ZoomAnimator.h"
#import "ZoomDismissalInteractionController.h"
@class ZoomAnimator;

@protocol ZoomAnimatorDelegate <NSObject>
-(void) transitionWillStartWith: (ZoomAnimator*)zoomAnimator;
-(void) transitionDidEndWith: (ZoomAnimator*)zoomAnimator;
-(UIImageView*) refereneImageViewFor: (ZoomAnimator*)zoomAnimator;
-(CGRect*) refereneImageViewFrameInTransitioningViewFor: (ZoomAnimator*)zoomAnimator;
@end
