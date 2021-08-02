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
#import "ButtonsDelegate.h"
#import "PanelButtonPosition.h"
#import "ButtonsViewController.h"
#import "ViewControllerHelper.h"
#import "NavigationController.h"
#import "PipContainerView.h"

@interface TabBarController () <ButtonsDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) FeedViewController* feedVc;
@property (nonatomic, strong) CameraViewController* cameraVc;
@property (nonatomic, strong) ExploreViewController* exploreVc;

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* buttonsContainerView;
@property (nonatomic, strong) ButtonsViewController* buttonsController;

@property (nonatomic) CGFloat const buttonContainerHeight;
@property (nonatomic) CGFloat const distanceFromBottom;

@property (nonatomic, strong) UIColor* const leftPanelColor;
@property (nonatomic, strong) UIColor* const rightPanelColor;

@property (nonatomic) BOOL shouldAnimate;

@property (nonatomic, strong) PipContainerView* pipContainerView;

@end

@implementation TabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.buttonContainerHeight = 90;
        self.distanceFromBottom = -30;
        self.leftPanelColor = UIColor.blueColor;
        self.rightPanelColor = UIColor.redColor;
        self.shouldAnimate = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(tabBarDidAppear)
                name:@"tabBarDidAppear"
                object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(tabBarWillDisappear)
                name:@"tabBarWillDisappear"
                object:nil];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
    [self setUpButtonContainerView];
    [self setUpPipContainerView];
}

- (void)tabBarDidAppear{
    [self animateTabBarItems:NO];
    [self.scrollView setScrollEnabled:YES];
}

- (void)tabBarWillDisappear{
    [self animateTabBarItems:YES];
    [self.scrollView setScrollEnabled:NO];
}

- (void)setUpUI{
    self.feedVc = [[FeedViewController alloc]init];
    self.cameraVc = [[CameraViewController alloc]init];
    self.exploreVc = [[ExploreViewController alloc]init];
    
    NSArray<UIViewController*>* viewControllers = @[
        [[NavigationController alloc]initWithRootViewController:self.feedVc],
        [[NavigationController alloc]initWithRootViewController:self.cameraVc],
        [[NavigationController alloc]initWithRootViewController:self.exploreVc]
    ];
    
    self.scrollView = [ScrollViewHelper makeHorizontalScrollViewWithViewControllers:viewControllers withParentViewController:self];
    self.scrollView.delegate = self;
    
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
    
    self.buttonsController = [[ButtonsViewController alloc]init];
    self.buttonsController.delegate = self;
    [ViewControllerHelper addChildVcToParentVc:self childVc:self.buttonsController containerView:self.buttonsContainerView];
}

- (void) animateTabBarItems: (BOOL)hidden{
    [UIView animateWithDuration:0.2 animations:^{
        self.buttonsContainerView.alpha = hidden ? 0 : 1;
    }];
}

- (void)setUpPipContainerView{
    self.pipContainerView = [[PipContainerView alloc]initWithFrame:self.view.bounds];
    self.pipContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.pipContainerView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pipContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.pipContainerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.pipContainerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.pipContainerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
}

//MARK:- Buttons Delegate
- (void)captureButtonPressed{
    [self.cameraVc captureButtonPressed];
}

- (void)backToCamerea{}

- (void)scrollToPosition: (PanelButtonPosition)posiiton {
    self.shouldAnimate = self.scrollView.contentOffset.x == UIScreen.mainScreen.bounds.size.width || posiiton == center;
    switch (posiiton) {
        case left:
            [self.scrollView setContentOffset:CGPointZero animated:YES];
            break;
        case right:
            [self.scrollView setContentOffset:CGPointMake(UIScreen.mainScreen.bounds.size.width * 2, 0) animated:YES];
            break;
        case center:
            [self.scrollView setContentOffset:CGPointMake(UIScreen.mainScreen.bounds.size.width, 0) animated:YES];
            break;
        default:
            break;
    }
}

//MARK:- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.shouldAnimate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.shouldAnimate) { return; }
    CGFloat offset = (scrollView.contentOffset.x / self.view.frame.size.width) - 1;
    [self.buttonsController animateButtonsWithOffset:offset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x <= 0){
        self.buttonsController.currentViewControllerPosition = left;
    }else if (scrollView.contentOffset.x <= UIScreen.mainScreen.bounds.size.width){
        self.buttonsController.currentViewControllerPosition = center;
    }else{
        self.buttonsController.currentViewControllerPosition = right;
    }
}
@end
