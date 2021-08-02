//
//  PipContainerView.m
//  FBU Final Project
//
//  Created by Keng Fontem on 8/2/21.
//

#import "PipContainerView.h"

@interface PipContainerView()

@property (readonly) NSArray* pipPositions;

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

//MARK:- Init Methods
- (instancetype)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder: (NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self setUpInitialValues];
    [self setUpPlaceholderViews];
}

//MARK:- Varible Getters and Setters

- (NSArray*)pipPositions{
    NSArray* values = [[NSArray alloc]init];
    for (const UIView* view in _pipPositionViews){
        NSValue* value = [NSValue valueWithCGPoint:view.center];
        values = [values arrayByAddingObject:value];
    }
    return values;
}

//MARK:- Init helper methods

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

//MARK:- Pip Animation Gestures Logic

- (void)pipPannedWithRecognizer: (UIPanGestureRecognizer*)recognizer{
    
}

- (CGFloat)projectWithInitialVelocity: (CGFloat)initialVelocity withDecelerationRate: (CGFloat)declerationRate{
    return (initialVelocity / 1000.0) * declerationRate / (1 - declerationRate);
}

- (CGPoint)nearestCornerToPoint: (CGPoint)point{
    CGFloat minDistance = CGFLOAT_MAX;
    CGPoint closestPosition = CGPointZero;
    
    for (const NSValue* value in self.pipPositions){
        const CGPoint position = [value CGPointValue];
        const CGFloat distance = [self distanceBetween:point and:position];
        if (distance < minDistance){
            closestPosition = position;
            minDistance = distance;
        }
    }
    
    return closestPosition;
}

- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2{
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

- (CGFloat)relativeVelocityForVelocity: (CGFloat)velocity fromCurrentValue: (CGFloat)currentValue toTargetValue: (CGFloat)targetValue{
    if ((currentValue - targetValue) == 0.0) { return 0.0; }
    return velocity / (targetValue - currentValue);
}

@end
