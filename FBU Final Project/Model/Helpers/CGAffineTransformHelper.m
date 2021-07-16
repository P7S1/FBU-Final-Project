//
//  CGAffineTransformHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "CGAffineTransformHelper.h"

@implementation CGAffineTransformHelper

+ (CGAffineTransform)transformFromRect: (CGRect)sourceRect toRect:(CGRect)finalRect{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, -(CGRectGetMidX(sourceRect)-CGRectGetMidX(finalRect)), -(CGRectGetMidY(sourceRect)-CGRectGetMidY(finalRect)));
    transform = CGAffineTransformScale(transform, finalRect.size.width/sourceRect.size.width, finalRect.size.height/sourceRect.size.height);

    return transform;
}

@end
