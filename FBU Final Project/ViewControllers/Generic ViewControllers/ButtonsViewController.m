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

@property (nonatomic, strong) UIButton* leftButton;
@property (nonatomic, strong) UIButton* centerButton;
@property (nonatomic, strong) UIButton* rightButton;

@end

@implementation ButtonsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftButton = [ScrollViewHelper makeUIButtonWithSide:left];
        self.rightButton = [ScrollViewHelper makeUIButtonWithSide:right];
        self.centerButton = [ScrollViewHelper makeUIButtonWithSide:center];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUi];
    [self configureCenterButton];
}

- (void) setUpUi{
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

- (void) configureCenterButton{
    CGFloat const centralButtonHeight = 70;
    CGFloat const ringViewDistanceFromEdges = 4;
    
    self.centerButton.backgroundColor = UIColor.whiteColor;
    
    CGSize ringViewSize = CGSizeMake(centralButtonHeight - (ringViewDistanceFromEdges * 2), centralButtonHeight - (ringViewDistanceFromEdges * 2));
    CGPoint ringViewPoint = CGPointMake(ringViewDistanceFromEdges, ringViewDistanceFromEdges);
    
    CALayer *maskLayer = [CAShapeLayer layer];
    maskLayer.borderColor = UIColor.blackColor.CGColor;
    maskLayer.borderWidth = 2;
    maskLayer.cornerRadius = (centralButtonHeight - (ringViewDistanceFromEdges * 2)) / 2;
    maskLayer.frame = (CGRect){ringViewPoint, ringViewSize};

    [self.centerButton.layer addSublayer:maskLayer];
}

- (void) changePanel: (UIButton*) sender{
    switch (sender.tag) {
        case left:
            [self.delegate scrollToPosition:left];
            break;
        case center:
            [self.delegate scrollToPosition:center];
            break;
        case right:
            [self.delegate scrollToPosition:right];
            break;
        default:
            break;
    }
}

- (void) animateButtonsWithOffset: (CGFloat)offset{
    
    CGFloat const sideButtonMargin =  32;
    CGFloat const distanceFromYCenter = 10;
    CGFloat const centralButtonHeight = 70;
    CGFloat const sideButtonHeight = 42;
    
    CGFloat buttonsSpacing = UIScreen.mainScreen.bounds.size.width / 2 - centralButtonHeight / 2 - sideButtonMargin * 2 - sideButtonHeight / 2;
    
    self.leftButton.center = CGPointMake((sideButtonMargin + sideButtonHeight) / 2 + buttonsSpacing * fabs(offset), self.leftButton.center.y);
    self.rightButton.center = CGPointMake(UIScreen.mainScreen.bounds.size.width - (sideButtonMargin + sideButtonHeight) / 2 - buttonsSpacing * fabs(offset), self.rightButton.center.y);
    self.centerButton.center = CGPointMake(self.centerButton.center.x, (self.view.frame.size.height / 2 - distanceFromYCenter) + distanceFromYCenter * fabs(offset));
}

@end
