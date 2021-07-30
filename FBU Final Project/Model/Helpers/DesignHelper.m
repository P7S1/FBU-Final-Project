//
//  DesignHelper.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "DesignHelper.h"

@implementation DesignHelper

+ (UIColor*)buttonBackgroundColor{
    return [[[UIApplication sharedApplication] delegate] window].tintColor;
}

+ (UIColor*)buttonTitleLabelColor{
    return UIColor.whiteColor;
}

@end
