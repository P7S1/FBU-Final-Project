//
//  BasicLabel.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "BasicLabel.h"

@implementation BasicLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topInset = 0;
        self.bottomInset = 0;
        self.leftInset = 0;
        self.rightInset = 0;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topInset, self.leftInset, self.bottomInset, self.rightInset);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)intrinsicContentSize{
    CGSize const size = [super intrinsicContentSize];
    return CGSizeMake(size.width + self.leftInset + self.rightInset,
                      size.height + self.topInset + self.bottomInset);
}

@end
