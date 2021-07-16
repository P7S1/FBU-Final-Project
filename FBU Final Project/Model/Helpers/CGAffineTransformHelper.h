//
//  CGAffineTransformHelper.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGAffineTransformHelper : NSObject

+ (CGAffineTransform)transformFromRect: (CGRect)sourceRect toRect:(CGRect)finalRect;

@end

NS_ASSUME_NONNULL_END
