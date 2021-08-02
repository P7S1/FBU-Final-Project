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

const CGFloat _pipWidth = 86.0;
const CGFloat _pipHeight = 130.0;

const CGFloat _horizontalSpacing = 23.0;
const CGFloat _verticalSpacing = 25.0;

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
    [self setUserInteractionEnabled:NO];
    [self setUpInitialValues];
    [self setUpPlaceholderViews];
}

//MARK:- Lifecycle Methods

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.pipPositions.lastObject == nil){
        _pipView.center = CGPointZero;
    }else{
        NSValue* value = self.pipPositions.lastObject;
        _pipView.center = [value CGPointValue];
    }
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
    [_pipView setUserInteractionEnabled:YES];
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
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self handlePanRecognizerStateBegan:recognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self handlePanRecognizerStateChanged:recognizer];
            break;
        case UIGestureRecognizerStateCancelled:
            [self handlePanRecognizerStateCancelled:recognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self handlePanRecognizerStateEnded:recognizer];
            break;
        default:
            break;
    }
}

- (void)handlePanRecognizerStateBegan: (UIPanGestureRecognizer*)recognizer{
    const CGPoint touchPoint = [recognizer locationInView:self];
    _initialOffset = CGPointMake(touchPoint.x - _pipView.center.x, touchPoint.y - _pipView.center.y);
    
}

- (void)handlePanRecognizerStateChanged: (UIPanGestureRecognizer*)recognizer{
    const CGPoint touchPoint = [recognizer locationInView:self];
    _initialOffset = CGPointMake(touchPoint.x - _initialOffset.x, touchPoint.y - _initialOffset.y);
}

- (void)handlePanRecognizerStateEnded: (UIPanGestureRecognizer*)recognizer{
    const CGFloat decelerationRate = UIScrollViewDecelerationRateNormal;
    const CGPoint velocity = [recognizer velocityInView:self];
    const CGPoint projectedPosition = (CGPoint){
        _pipView.center.x + [self projectWithInitialVelocity:velocity.x withDecelerationRate:decelerationRate],
         _pipView.center.y + [self projectWithInitialVelocity:velocity.y withDecelerationRate:decelerationRate]
    };
    const CGPoint nearestCornerPosition = [self nearestCornerToPoint:projectedPosition];
    const CGVector relativeInitalVelocity = (CGVector){
        [self relativeVelocityForVelocity:velocity.x fromCurrentValue:_pipView.center.x toTargetValue:nearestCornerPosition.x],
        [self relativeVelocityForVelocity:velocity.y fromCurrentValue:_pipView.center.y toTargetValue:nearestCornerPosition.y]
    };
    
    const UISpringTimingParameters* timingParemeters = [[UISpringTimingParameters alloc]initWithDampingRatio:1.0 initialVelocity:relativeInitalVelocity];
    const UIViewPropertyAnimator* animatior = [[UIViewPropertyAnimator alloc]initWithDuration:0.0 timingParameters:timingParemeters];
    [animatior addAnimations:^{
        _pipView.center = nearestCornerPosition;
    }];
    
    [animatior startAnimation];
}

- (void)handlePanRecognizerStateCancelled: (UIPanGestureRecognizer*)recognizer{
    [self handlePanRecognizerStateEnded:recognizer];
}


- (CGFloat)projectWithInitialVelocity: (CGFloat)initialVelocity withDecelerationRate: (CGFloat)declerationRate{
    return (initialVelocity / 1000.0) * declerationRate / (1.0 - declerationRate);
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
