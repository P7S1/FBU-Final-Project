//
//  BasicButton.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/15/21.
//

#import "BasicButton.h"

@interface BasicButton ()

@property (nonatomic, strong) CALayer* coverLayer;

@end

@implementation BasicButton

- (instancetype)init{
    self = [super init];
    if (self) {
        self.coverLayer = [[CALayer alloc]init];
        self.coverLayer.backgroundColor = UIColor.blackColor.CGColor;
        self.coverLayer.opacity = 0.0;
        self.layer.cornerRadius = 25;
        [self.layer addSublayer:self.coverLayer];
        
        [self addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(buttonRelease) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit | UIControlEventTouchCancel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverLayer.frame = self.bounds;
    self.coverLayer.cornerRadius = self.layer.cornerRadius;
}

- (void)buttonPress{
    self.coverLayer.opacity = 0.0;
    [UIView animateWithDuration:0.1 animations:^{
        self.coverLayer.opacity = 0.6;
        self.transform = CGAffineTransformMakeScale(1.15, 1.15);
    }];
}

- (void)buttonRelease{
    self.coverLayer.opacity = 0.6;
    [UIView animateWithDuration:0.1 animations:^{
        self.coverLayer.opacity = 0.0;
        self.transform = CGAffineTransformIdentity;
    }];
}

@end
