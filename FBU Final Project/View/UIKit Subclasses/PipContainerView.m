//
//  PipContainerView.m
//  FBU Final Project
//
//  Created by Keng Fontem on 8/2/21.
//

#import "PipContainerView.h"

@interface PipContainerView()

@property (nonatomic, strong) NSArray<UIView*>* pipPositionViews;

@end

@implementation PipContainerView

NSArray<UIView*>* _pipPositionViews;
UIView* _pipView;

const CGFloat _pipWidth = 86;
const CGFloat _pipHeight = 130;

const CGFloat _horizontalSpacing = 23;
const CGFloat _verticalSpacing = 25;

- (instancetype)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInitialValues];
        [self createPipView];
    }
    return self;
}

- (void)setUpInitialValues{
    self.pipPositionViews = [[NSArray alloc]init];
    _pipView = [[UIView alloc]init];
    _pipView.backgroundColor = UIColor.greenColor;
}

- (UIView*)getPipView{
    UIView* pipView = [[UIView alloc]init];
    [self addSubview:pipView];
    
    pipView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [pipView.heightAnchor constraintEqualToConstant:_pipHeight],
        [pipView.widthAnchor constraintEqualToConstant:_pipWidth]
    ]];
    
    _pipPositionViews = [self.pipPositionViews arrayByAddingObject:pipView];
    
    return pipView;
}

@end
