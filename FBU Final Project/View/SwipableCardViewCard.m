//
//  SwipableCardViewCard.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

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
    
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}


//MARK:- Tap Gesture Recognizer
- (void) tapGestureRecognized: (UITapGestureRecognizer*)recognizer{
    [self.delegate didTapView:self];
}

@end
