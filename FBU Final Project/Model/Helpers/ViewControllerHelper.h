//
//  ViewControllerHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerHelper : NSObject

+ (void)addChildVcToParentVc: (UIViewController*)parent childVc: (UIViewController*)childVc containerView: (UIView*)containerView;

@end

NS_ASSUME_NONNULL_END
