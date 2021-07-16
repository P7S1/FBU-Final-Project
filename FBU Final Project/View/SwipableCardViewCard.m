//
//  SwipableCardViewCard.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "SwipableCardViewCard.h"
#import "SwipeableCardViewDataSource.h"

@interface SwipableCardViewCard ()

//Gesture Regozniers
@property (nonatomic, strong, nullable) UIPanGestureRecognizer* panGestureRecognizer;
@property (nonatomic) CGPoint panGestureTranslation;
@property (nonatomic, strong, nullable) UITapGestureRecognizer* tapGestureRecognizer;

//Drag animation settings
@property (nonatomic) CGFloat const maximumRotation;
@property (nonatomic) CGFloat const rotationAngle;
@property (nonatomic) CGFloat const animationDirectionY;
@property (nonatomic) CGFloat const swipePercentageMargin;

//Card Finalise Swipe Animation
@property (nonatomic) NSTimeInterval const finalizeSwipeActionAnimationDuration;

//Card Reset Animation
@property (nonatomic) CGFloat const cardViewResetAnimationSpringBounciness;
@property (nonatomic) CGFloat const cardViewResetAnimationSpringSpeed;
@property (nonatomic) CGFloat const cardViewResetAnimationDuration;

@end

@implementation SwipableCardViewCard

- (instancetype)init{
    self = [super init];
    if (self) {
        self.panGestureTranslation = CGPointZero;
        
        self.maximumRotation = 1.0;
        self.rotationAngle = M_PI / 10.0;
        self.animationDirectionY = 1.0;
        self.swipePercentageMargin = 0.6;
        
        self.finalizeSwipeActionAnimationDuration = 0.8;
        
        self.cardViewResetAnimationSpringBounciness = 10.0;
        self.cardViewResetAnimationSpringSpeed = 20.0;
        self.cardViewResetAnimationDuration = 0.2;
        
        [self setUpGestureRecognizers];
    }
    return self;
}

- (void)setUpGestureRecognizers{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

//MARK:- Pan Gesture Recognizer
- (void)panGestureRecognized: (UIPanGestureRecognizer*)gestureRecognizer{
    self.panGestureTranslation = [gestureRecognizer translationInView:self];
    switch ([gestureRecognizer state]){
        case UIGestureRecognizerStateBegan:
            //[self handlePanGestureStateBegan:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self handlePanGestureStateChanged:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self handlePanGestureStateEnded:gestureRecognizer];
            break;
        default:
            [self handlePanGestureStateDefault:gestureRecognizer];
            break;
    }
}

- (void)handlePanGestureStateBegan: (UIPanGestureRecognizer*)gestureRecognizer{
    [self layoutIfNeeded];
    CGPoint const initialTouchPoint = [gestureRecognizer locationInView:self];
    CGPoint const newAnchorPoint = CGPointMake(initialTouchPoint.x / self.bounds.size.width, initialTouchPoint.y / self.bounds.size.height);
    CGPoint const oldPosition = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    CGPoint const newPosition = CGPointMake(self.bounds.size.width * newAnchorPoint.x, self.bounds.size.width * newAnchorPoint.y);
    
    self.layer.anchorPoint = newAnchorPoint;
    self.layer.position = CGPointMake(self.layer.position.x - oldPosition.x + newPosition.x, self.layer.position.y - oldPosition.y + newPosition.y);
    
    [self removeAnimations];
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
    self.layer.shouldRasterize = YES;
    
    [self.delegate didBeginSwipeOnView:self];
}

- (void)handlePanGestureStateChanged: (UIPanGestureRecognizer*)gestureRecognizer{
    CGFloat const rotationStrength = MIN(self.panGestureTranslation.x / self.frame.size.width, self.maximumRotation);
    CGFloat const rotationAngle = self.animationDirectionY * self.rotationAngle * rotationStrength;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1);
    transform = CATransform3DTranslate(transform, self.panGestureTranslation.x, self.panGestureTranslation.y, 0);
    self.layer.transform = transform;
}

- (void)handlePanGestureStateEnded: (UIPanGestureRecognizer*)gestureRecognizer{
    [self endedPanAnimation];
    self.layer.shouldRasterize = NO;
}

- (void)handlePanGestureStateDefault: (UIPanGestureRecognizer*)gestureRecognizer{
    [self resetCardViewPosition];
    self.layer.shouldRasterize = NO;
}

- (void)endedPanAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}

- (void)resetCardViewPosition{
    [self removeAnimations];
    
    POPSpringAnimation *resetSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:@"kPOPLayerTranslationXY"];
    resetSpringAnimation.fromValue = [NSValue valueWithCGPoint:POPLayerGetTranslationXY(self.layer)];
    resetSpringAnimation.toValue = [NSValue valueWithCGPoint:CGPointZero];
    resetSpringAnimation.springBounciness = self.cardViewResetAnimationSpringBounciness;
    resetSpringAnimation.springSpeed = self.cardViewResetAnimationSpringSpeed;
    resetSpringAnimation.completionBlock =  ^(POPAnimation *anim, BOOL finished){
        self.layer.transform = CATransform3DIdentity;
    };
    
    [self.layer pop_addAnimation:resetSpringAnimation forKey:@"resetPositionAnimation"];
    
    //Reset Rotation
    POPBasicAnimation *resetRotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    resetRotationAnimation.fromValue = @(POPLayerGetRotationZ(self.layer));
    resetRotationAnimation.toValue = @(0.0);
    resetRotationAnimation.duration = self.cardViewResetAnimationDuration;
    
    [self.layer pop_addAnimation:resetRotationAnimation forKey:@"resetRotationAnimation"];
}

- (void)removeAnimations{
    [POPAnimator pop_removeAllAnimations];
    [self.layer pop_removeAllAnimations];
}

//MARK:- Tap Gesture Recognizer
- (void)tapGestureRecognized: (UITapGestureRecognizer*)recognizer{
    [self.delegate didTapView:self];
}

@end
