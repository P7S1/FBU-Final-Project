//
//  PipContainerView.m
//  FBU Final Project
//
//  Created by Keng Fontem on 8/2/21.
//

#import "PipContainerView.h"

@interface PipContainerView()

@end

@implementation PipContainerView

NSArray<UIView*>* _pipPositionViews;
UIView* _pipView;

const CGFloat _pipWidth = 86;
const CGFloat _pipHeight = 130;

const CGFloat _horizontalSpacing = 23;
const CGFloat _verticalSpacing = 25;

CGPoint _initialOffset;
UIPanGestureRecognizer* _panRecognizer;

- (instancetype)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInitialValues];
        [self setUpPlaceholderViews];
    }
    return self;
}

- (void)setUpInitialValues{
    _pipPositionViews = [[NSArray alloc]init];
    
    _initialOffset = CGPointZero;
    
    _panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pipPannedWithRecognizer:)];
    
    _pipView = [[UIView alloc]init];
    _pipView.backgroundColor = UIColor.greenColor;
    [self addSubview:_pipView];
    _pipView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_pipView.heightAnchor constraintEqualToConstant:_pipHeight],
        [_pipView.widthAnchor constraintEqualToConstant:_pipWidth]
    ]];
    
    [_pipView addGestureRecognizer:_panRecognizer];
}

- (void)setUpPlaceholderViews{
    const UIView* topLeftView = [self getPipView];
    const UIView* topRightView = [self getPipView];
    const UIView* bottomLeftView = [self getPipView];
    const UIView* bottomRightView = [self getPipView];
    
    [NSLayoutConstraint activateConstraints:@[
        [topLeftView.topAnchor constraintEqualToAnchor:self.topAnchor constant:_verticalSpacing],
        [topLeftView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:_horizontalSpacing],
        [topRightView.topAnchor constraintEqualToAnchor:self.topAnchor constant:_verticalSpacing],
        [topRightView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-_horizontalSpacing],
        [bottomLeftView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-_verticalSpacing],
        [bottomLeftView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:_horizontalSpacing],
        [bottomRightView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-_verticalSpacing],
        [bottomRightView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-_horizontalSpacing]
    ]];
}

- (UIView*)getPipView{
    UIView* pipView = [[UIView alloc]init];
    [self addSubview:pipView];
    
    pipView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [pipView.heightAnchor constraintEqualToConstant:_pipHeight],
        [pipView.widthAnchor constraintEqualToConstant:_pipWidth]
    ]];
    
    _pipPositionViews = [_pipPositionViews arrayByAddingObject:pipView];
    
    return pipView;
}

- (void)pipPannedWithRecognizer: (UIPanGestureRecognizer*)recognizer{
    
}

@end
