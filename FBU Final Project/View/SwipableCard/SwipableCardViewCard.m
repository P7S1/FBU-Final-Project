//
//  SwipableCardViewCard.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "SwipableCardViewCard.h"
#import "SwipeableCardViewDataSource.h"
#import "CGAffineTransformHelper.h"
#import "PanelButtonPosition.h"
#import "BasicLabel.h"

@interface SwipableCardViewCard ()

//Gesture Regozniers
@property (nonatomic, strong, nullable) UIPanGestureRecognizer* panGestureRecognizer;
@property (nonatomic) CGPoint panGestureTranslation;
@property (nonatomic, strong, nullable) UITapGestureRecognizer* tapGestureRecognizer;

//Drag animation settings
@property (nonatomic) CGFloat const animationCompletionThreshold;
@property (nonatomic) CGFloat initialXPosition;

//Decision Labels
@property (nonatomic, strong) BasicLabel* yesDecisionLabel;
@property (nonatomic, strong) BasicLabel* noDecisionLabel;

@property (nonatomic, strong) UIVisualEffectView* blurView;
    
@end

@implementation SwipableCardViewCard

CGFloat const _swipePercentageMargin = 0.6;
CGFloat const _maximumRotation = 1.0;
CGFloat const _rotationAngle = M_PI / 10.0;
CGFloat const _animationDirectionY = 1.0;

//Card Reset Animation
CGFloat const _cardViewResetAnimationSpringBounciness = 10.0;
CGFloat const _cardViewResetAnimationSpringSpeed = 20.0;
CGFloat const _cardViewResetAnimationDuration = 0.2;
CGFloat const _finalizeSwipeActionAnimationDuration = 0.8;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.panGestureTranslation = CGPointZero;

        self.animationCompletionThreshold = 90;
        
        [self setUpGestureRecognizers];
        [self setUpUI];
    }
    return self;
}

- (void)setUpGestureRecognizers{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void) setUpUI{
    //UI customization
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 20;
    
    self.shadowLayer = [[CALayer alloc]init];
    self.shadowLayer.backgroundColor = UIColor.blackColor.CGColor;
    self.shadowLayer.opacity = 0.0;
    [self.layer insertSublayer:self.shadowLayer atIndex:0];
    
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.backgroundImageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.backgroundImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.backgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.backgroundImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.backgroundImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor]
    ]];
    
    
    UIVisualEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:effect];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.blurView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.blurView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.blurView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.blurView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.blurView.rightAnchor constraintEqualToAnchor:self.rightAnchor]
    ]];
    
    self.backgroundColor = UIColor.systemBackgroundColor;
    
    //StackView Components
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Title";
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = UIColor.whiteColor;
    
    self.itemImageView = [[UIImageView alloc]init];
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.itemImageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemImageView.layer.cornerRadius = 20;
    self.itemImageView.layer.masksToBounds = YES;
    self.itemImageView.clipsToBounds = YES;
    CGFloat const itemImageViewSizeConstant = UIScreen.mainScreen.bounds.size.width - ((16 + 32) * 2);
    [NSLayoutConstraint activateConstraints:@[
        [self.itemImageView.heightAnchor constraintEqualToConstant:itemImageViewSizeConstant],
        [self.itemImageView.widthAnchor constraintEqualToConstant:itemImageViewSizeConstant]
    ]];
    
    self.descriptionLabel = [[UILabel alloc]init];
    self.descriptionLabel.text = @"Description Label la la la la la la la";
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.textColor = UIColor.whiteColor;
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.textColor = UIColor.whiteColor;
    self.dateLabel.text = @"3 days ago";
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    //StackView
    UIStackView* stackView = [[UIStackView alloc]initWithArrangedSubviews:@[
        self.titleLabel,
        self.itemImageView,
        self.descriptionLabel,
        self.dateLabel
    ]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.spacing = 4;
    
    [self addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:32],
        [stackView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant:-32],
        [stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
    
    //Yes or No Decision Labels
    self.yesDecisionLabel = [self getADecisionLabelWithColor:UIColor.systemGreenColor withText:@"ADD TO CART"];
    self.noDecisionLabel = [self getADecisionLabelWithColor:UIColor.redColor withText:@"MAYBE LATER"];
    
    CGFloat const rotationAngle = M_PI / 4;
    self.yesDecisionLabel.transform = CGAffineTransformMakeRotation(rotationAngle);
    self.noDecisionLabel.transform = CGAffineTransformMakeRotation(-rotationAngle);
}

- (BasicLabel*) getADecisionLabelWithColor:(UIColor*)color withText:(NSString*)text{
    BasicLabel* label = [[BasicLabel alloc]init];
    label.font = [UIFont systemFontOfSize:30.0 weight:UIFontWeightBold];
    label.text = text;
    label.textColor = color;
    label.layer.cornerRadius = 10.0;
    label.layer.borderColor = color.CGColor;
    label.layer.borderWidth = 8.0;
    label.alpha = 0.0;
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
    
    CGFloat const inset = 16.0;
    
    label.topInset = inset;
    label.leftInset = inset;
    label.rightInset = inset;
    label.bottomInset = inset;
    
    return label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.shadowLayer.frame = self.layer.bounds;
}

//MARK:- Pan Gesture Recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer*)gestureRecognizer{
    self.panGestureTranslation = [gestureRecognizer translationInView:self];
    switch ([gestureRecognizer state]){
        case UIGestureRecognizerStateBegan:
            [self handlePanGestureStateBegan:gestureRecognizer];
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

- (void)handlePanGestureStateBegan:(UIPanGestureRecognizer*)gestureRecognizer{
    [self layoutIfNeeded];
    
    self.initialXPosition = [gestureRecognizer locationInView:nil].x;
    
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
    self.layer.shouldRasterize = YES;
    
    [self.delegate didBeginSwipeOnView:self];
}

- (void)handlePanGestureStateChanged:(UIPanGestureRecognizer*)gestureRecognizer{
    CGFloat const rotationStrength = MIN(self.panGestureTranslation.x / self.frame.size.width, _maximumRotation);
    CGFloat const rotationAngle = _animationDirectionY * _rotationAngle * rotationStrength;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1);
    transform = CATransform3DTranslate(transform, self.panGestureTranslation.x, self.panGestureTranslation.y, 0);
    self.layer.transform = transform;
    
    CGFloat const fullLabelAlphaThreshold = self.animationCompletionThreshold;
    CGFloat const locationInView = [gestureRecognizer locationInView:nil].x;
    CGFloat const relativeDistance = fabs(locationInView - self.initialXPosition);
    
    CGFloat const progress = MIN(fabs(relativeDistance) /  fullLabelAlphaThreshold, 1.0);
    
    if (locationInView > self.initialXPosition){
        self.yesDecisionLabel.alpha = progress;
        self.noDecisionLabel.alpha = 0.0;
    }else{
        self.yesDecisionLabel.alpha = 0.0;
        self.noDecisionLabel.alpha = progress;
    }
}

- (void)handlePanGestureStateEnded:(UIPanGestureRecognizer*)gestureRecognizer{
    [self layoutIfNeeded];
    CGFloat const locationInView = [gestureRecognizer locationInView:nil].x;
    CGFloat const absoluteDistance = fabs(locationInView - self.initialXPosition);
    
    if (absoluteDistance <= self.animationCompletionThreshold){
        [self resetCardViewPosition];
        return;
    }
    if (locationInView > self.initialXPosition){
        [self endPanAnimationTowardsDirection:right];
    }else{
        [self endPanAnimationTowardsDirection:left];
    }
    self.layer.shouldRasterize = NO;
}

- (void)handlePanGestureStateDefault:(UIPanGestureRecognizer*)gestureRecognizer{
    [self resetCardViewPosition];
    self.layer.shouldRasterize = NO;
}

- (void)endPanAnimationTowardsDirection:(PanelButtonPosition)direction{
    CGFloat const xPosition = direction == left ? -UIScreen.mainScreen.bounds.size.height : UIScreen.mainScreen.bounds.size.height;
    CGRect const toRect = CGRectMake(xPosition, UIScreen.mainScreen.bounds.size.height - self.frame.size.width, self.frame.size.height, self.frame.size.width);
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = [CGAffineTransformHelper transformFromRect:self.frame toRect:toRect];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.layer.transform = CATransform3DIdentity;
            self.transform = CGAffineTransformIdentity;
            self.yesDecisionLabel.alpha = 0.0;
            self.noDecisionLabel.alpha = 0.0;
    }];
    
    [self.delegate didSwipeAwayView:self towardsDirection:direction];
}

- (void)resetCardViewPosition{
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.transform = CATransform3DIdentity;
        self.yesDecisionLabel.alpha = 0.0;
        self.noDecisionLabel.alpha = 0.0;
    }];
}

//MARK:- Tap Gesture Recognizer
- (void)tapGestureRecognized: (UITapGestureRecognizer*)recognizer{
    [self.delegate didTapView:self];
}

//MARK:- Dismiss Card Towards Direction
- (void)dismissCardTowardsDirection:(PanelButtonPosition)direction{
    [self endPanAnimationTowardsDirection:direction];
}

@end
