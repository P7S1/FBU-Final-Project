//
//  TabBarController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "TabBarController.h"
#import "FeedViewController.h"
#import "CameraViewController.h"
#import "ExploreViewController.h"
#import "ScrollViewHelper.h"

@interface TabBarController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* buttonsContainerView;

@property (nonatomic) CGFloat const buttonContainerHeight;
@property (nonatomic) CGFloat const distanceFromBottom;

@property (nonatomic, strong) UIColor* const leftPanelColor;
@property (nonatomic, strong) UIColor* const rightPanelColor;

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buttonContainerHeight = 80;
        self.distanceFromBottom = -30;
        self.leftPanelColor = UIColor.blueColor;
        self.rightPanelColor = UIColor.redColor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void) setUpUI{
    FeedViewController* feedVc = [[FeedViewController alloc]init];
    CameraViewController* cameraVc = [[CameraViewController alloc]init];
    ExploreViewController* exploreVc = [[ExploreViewController alloc]init];
    
    NSArray<UIViewController*>* viewControllers = @[feedVc, cameraVc, exploreVc];
    
    self.scrollView = [ScrollViewHelper   makeHorizontalScrollViewWithViewControllers:viewControllers withParentViewController:self];
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.scrollEnabled = YES;
    [NSLayoutConstraint activateConstraints: @[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
    
    self.scrollView.delegate = self;
}

- (void) setUpButtonContainerView{
    self.buttonsContainerView = [[UIView alloc]init];
    [self.view insertSubview:self.buttonsContainerView aboveSubview:self.scrollView];
    
    self.buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false;
    CGFloat bottomDistance = self.distanceFromBottom;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.buttonsContainerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.buttonsContainerView.heightAnchor constraintEqualToConstant:self.buttonContainerHeight],
        [self.buttonsContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.buttonsContainerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:bottomDistance]
    ]];
    
    
}

@end
