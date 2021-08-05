//
//  PipContainerView.m
//  FBU Final Project
//
//  Created by Keng Fontem on 8/2/21.
//

#import "PipContainerView.h"
#import "BasicButton.h"
#import "CartViewController.h"

@interface PipContainerView()

@property (readonly) NSArray* pipPositions;

@end

@implementation PipContainerView

UIViewController* _presentingViewController;
NSArray<UIView*>* _pipPositionViews;
BasicButton* _pipButton;

CGPoint _lastPipPosition;

const CGFloat _pipWidth = 70.0;
const CGFloat _pipHeight = 70.0;

const CGFloat _horizontalSpacing = 16.0;
const CGFloat _verticalSpacing = 52.0;

CGPoint _initialOffset;
UIPanGestureRecognizer* _panRecognizer;

//MARK:- Init Methods
- (instancetype)initWithViewController: (UIViewController*)viewController{
    self = [super init];
    if (self){
        _presentingViewController = viewController;
        [self commonInit];
        [viewController.view addSubview:_pipButton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
      
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)commonInit{
    [self setUserInteractionEnabled:NO];
    [self setUpInitialValues];
    [self setUpPlaceholderViews];
}

- (void)resetPipPosition{
    if (_lastPipPosition.x == 0.0 && _lastPipPosition.y == 0.0){
        if (self.pipPositions.lastObject == nil){
            _pipButton.center = CGPointZero;
        }else{
            NSValue* value = self.pipPositions.lastObject;
            _pipButton.center = [self convertPoint:[value CGPointValue] toView:self.superview];
        }
    }else{
        _pipButton.center = _lastPipPosition;
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
    
    _pipButton = [[BasicButton alloc]init];
    _pipButton.layer.cornerRadius = _pipHeight/2;
    _pipButton.layer.shadowColor = [UIColor.grayColor CGColor];
    _pipButton.layer.shadowOffset = CGSizeZero;
    _pipButton.layer.shadowRadius = 12.0;
    _pipButton.layer.shadowOpacity = 0.7;
    
    _pipButton.backgroundColor = UIColor.secondarySystemBackgroundColor;
    
    _pipButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_pipButton.heightAnchor constraintEqualToConstant:_pipHeight],
        [_pipButton.widthAnchor constraintEqualToConstant:_pipWidth]
    ]];
    
    [_pipButton addGestureRecognizer:_panRecognizer];
    [_pipButton addTarget:self action:@selector(pipButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage systemImageNamed:@"cart"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_pipButton addSubview:imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:_pipButton.topAnchor constant:_pipHeight * 0.25],
        [imageView.leftAnchor constraintEqualToAnchor:_pipButton.leftAnchor constant:_pipWidth * 0.25],
        [imageView.rightAnchor constraintEqualToAnchor:_pipButton.rightAnchor constant:-(_pipHeight * 0.25)],
        [imageView.bottomAnchor constraintEqualToAnchor:_pipButton.bottomAnchor constant:-(_pipWidth * 0.25)]
    ]];
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
    
    pipView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [pipView.heightAnchor constraintEqualToConstant:_pipHeight],
        [pipView.widthAnchor constraintEqualToConstant:_pipWidth]
    ]];
    
    [self addSubview:pipView];
    
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
    _initialOffset = CGPointMake(touchPoint.x - _pipButton.center.x, touchPoint.y - _pipButton.center.y);
    
}

- (void)handlePanRecognizerStateChanged: (UIPanGestureRecognizer*)recognizer{
    const CGPoint touchPoint = [recognizer locationInView:self];
    _pipButton.center = CGPointMake(touchPoint.x - _initialOffset.x, touchPoint.y - _initialOffset.y);
}

- (void)handlePanRecognizerStateEnded: (UIPanGestureRecognizer*)recognizer{
    const CGFloat decelerationRate = UIScrollViewDecelerationRateNormal;
    const CGPoint velocity = [recognizer velocityInView:self];
    const CGPoint projectedPosition = (CGPoint){
        _pipButton.center.x + [self projectWithInitialVelocity:velocity.x withDecelerationRate:decelerationRate],
         _pipButton.center.y + [self projectWithInitialVelocity:velocity.y withDecelerationRate:decelerationRate]
    };
    const CGPoint nearestCornerPosition = [self nearestCornerToPoint:projectedPosition];
    const CGVector relativeInitalVelocity = (CGVector){
        [self relativeVelocityForVelocity:velocity.x fromCurrentValue:_pipButton.center.x toTargetValue:nearestCornerPosition.x],
        [self relativeVelocityForVelocity:velocity.y fromCurrentValue:_pipButton.center.y toTargetValue:nearestCornerPosition.y]
    };
    
    const UISpringTimingParameters* timingParemeters = [[UISpringTimingParameters alloc]initWithDampingRatio:1.0 initialVelocity:relativeInitalVelocity];
    const UIViewPropertyAnimator* animatior = [[UIViewPropertyAnimator alloc]initWithDuration:0.0 timingParameters:timingParemeters];
    [animatior addAnimations:^{
        _pipButton.center = [self convertPoint:nearestCornerPosition toView:self.superview];
    }];
    
    [animatior addCompletion:^(UIViewAnimatingPosition finalPosition) {
        _lastPipPosition = [self convertPoint:nearestCornerPosition toView:self.superview];
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

//MARK:- Pip Button aciton

- (void)pipButtonPressed{
    CartViewController* vc = [[CartViewController alloc]init];
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:vc];
    [_presentingViewController presentViewController:navController animated:YES completion:nil];
}

- (void)setButtonHidden: (bool)hidden{
    [_pipButton setHidden:hidden];
}

@end
