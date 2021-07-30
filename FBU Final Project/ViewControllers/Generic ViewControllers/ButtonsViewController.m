//
//  ButtonsViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "ButtonsViewController.h"
#import "PanelButtonPosition.h"
#import "ScrollViewHelper.h"

@interface ButtonsViewController ()

@property (nonatomic, strong) BasicButton* leftButton;
@property (nonatomic, strong) BasicButton* centerButton;
@property (nonatomic, strong) BasicButton* rightButton;

@end

@implementation ButtonsViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.leftButton = [ScrollViewHelper makeUIButtonWithSide:left];
        self.rightButton = [ScrollViewHelper makeUIButtonWithSide:right];
        self.centerButton = [ScrollViewHelper makeUIButtonWithSide:center];
        self.currentViewControllerPosition = center;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUi];
    [self configureCenterButton];
}

- (void)setUpUi{
    CGFloat const sideButtonMargin =  32;
    CGFloat const distanceFromYCenter = 10;
    
    //Left Button
    self.leftButton.tag = left;
    [self.leftButton addTarget:self action:@selector(changePanel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.leftButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:distanceFromYCenter],
        [self.leftButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-UIScreen.mainScreen.bounds.size.width / 2 + sideButtonMargin]
    ]];
    
    //Center Button
    self.centerButton.tag = center;
    [self.centerButton addTarget:self action:@selector(changePanel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.centerButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.centerButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:distanceFromYCenter],
        [self.centerButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
    
    //Right Button
    self.rightButton.tag = right;
    [self.rightButton addTarget:self action:@selector(changePanel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.rightButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:distanceFromYCenter],
        [self.rightButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:UIScreen.mainScreen.bounds.size.width / 2 - sideButtonMargin]
    ]];
}

- (void)configureCenterButton{
    CGFloat const centralButtonHeight = 70;
    CGFloat const ringViewDistanceFromEdges = 5.5;

    const CGSize ringViewSize = CGSizeMake(centralButtonHeight - (ringViewDistanceFromEdges * 2), centralButtonHeight - (ringViewDistanceFromEdges * 2));
    const CGPoint ringViewPoint = CGPointMake(ringViewDistanceFromEdges, ringViewDistanceFromEdges);
    const CGRect ringViewRect = (CGRect){ringViewPoint, ringViewSize};
    
    const CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *circularPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0, 0.0, centralButtonHeight, centralButtonHeight) cornerRadius: centralButtonHeight];
    maskLayer.path = circularPath.CGPath;
    maskLayer.fillColor = UIColor.clearColor.CGColor;
    maskLayer.strokeColor = [UIColor blackColor].CGColor;
    maskLayer.lineWidth = 7;
    
    const CAShapeLayer *secondMaskLayer = [CAShapeLayer layer];
    circularPath = [UIBezierPath bezierPathWithRoundedRect:ringViewRect cornerRadius: centralButtonHeight];
    secondMaskLayer.path = circularPath.CGPath;
    secondMaskLayer.fillColor = [UIColor blackColor].CGColor;
    secondMaskLayer.strokeColor = [UIColor blackColor].CGColor;
    secondMaskLayer.lineWidth = 0.0;
    
    self.centerButton.layer.masksToBounds = true;
    self.centerButton.layer.shadowColor = UIColor.yellowColor.CGColor;
    self.centerButton.layer.shadowOffset = CGSizeZero;
    self.centerButton.layer.shadowOpacity = 0.9;
    self.centerButton.layer.shadowRadius = 10;
    
    [maskLayer addSublayer:secondMaskLayer];
    
    self.centerButton.layer.mask = maskLayer;
}

- (void)changePanel: (BasicButton*) sender{
    switch (sender.tag) {
        case left:
            [self.delegate scrollToPosition:left];
            self.currentViewControllerPosition = left;
            break;
        case center:
            if (self.currentViewControllerPosition == center){
                [self.delegate captureButtonPressed];
            }else{
                [self.delegate scrollToPosition:center];
                self.currentViewControllerPosition = center;
            }
            break;
        case right:
            [self.delegate scrollToPosition:right];
            self.currentViewControllerPosition = right;
            break;
        default:
            break;
    }
}

- (void)animateButtonsWithOffset: (CGFloat)offset{
    CGFloat const sideButtonMargin =  32;
    CGFloat const distanceFromYCenter = 10;
    CGFloat const centralButtonHeight = 70;
    CGFloat const sideButtonHeight = 42;
    
    CGFloat buttonsSpacing = UIScreen.mainScreen.bounds.size.width / 2 - centralButtonHeight / 2 - sideButtonMargin * 2 - sideButtonHeight / 2;
    
    self.leftButton.center = CGPointMake((sideButtonMargin + sideButtonHeight) / 2 + buttonsSpacing * fabs(offset), self.leftButton.center.y);
    self.rightButton.center = CGPointMake(UIScreen.mainScreen.bounds.size.width - (sideButtonMargin + sideButtonHeight) / 2 - buttonsSpacing * fabs(offset), self.rightButton.center.y);
    self.centerButton.center = CGPointMake(self.centerButton.center.x, (self.view.frame.size.height / 2 - distanceFromYCenter) + distanceFromYCenter * fabs(offset));
}

- (void)setCurrentViewControllerPosition:(PanelButtonPosition)currentViewControllerPosition{
    [self updateCurrentButtonLooksWithCurrentPosition:currentViewControllerPosition];
}

- (void)updateCurrentButtonLooksWithCurrentPosition: (PanelButtonPosition)position{
    const UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationWithPointSize:19.0 weight:UIImageSymbolWeightBold];
    
    UIImage* leftImage;
    UIImage* rightImage;
    UIImage* centerImage;
    
    if (position == left){
        leftImage = [UIImage systemImageNamed:@"house.fill" withConfiguration:config];
        rightImage = [UIImage systemImageNamed:@"star" withConfiguration:config];
        centerImage = [UIImage systemImageNamed:@"camera" withConfiguration:config];
    }else if (position == center){
        leftImage = [UIImage systemImageNamed:@"house" withConfiguration:config];
        rightImage = [UIImage systemImageNamed:@"star" withConfiguration:config];
        centerImage = [UIImage systemImageNamed:@"camera.fill" withConfiguration:config];
    }else{
        leftImage = [UIImage systemImageNamed:@"house" withConfiguration:config];
        rightImage = [UIImage systemImageNamed:@"star.fill" withConfiguration:config];
        centerImage = [UIImage systemImageNamed:@"camera" withConfiguration:config];
    }
    
    [self.leftButton setImage:leftImage forState:UIControlStateNormal];
    [self.rightButton setImage:rightImage forState:UIControlStateNormal];
    [self.centerButton setImage:centerImage forState:UIControlStateNormal];
}

@end
