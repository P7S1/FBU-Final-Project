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

@interface TabBarController () <ButtonsDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* buttonsContainerView;
@property (nonatomic, strong) ButtonsViewController* buttonsController;

@property (nonatomic) CGFloat const buttonContainerHeight;
@property (nonatomic) CGFloat const distanceFromBottom;

@property (nonatomic, strong) UIColor* const leftPanelColor;
@property (nonatomic, strong) UIColor* const rightPanelColor;

@property (nonatomic) BOOL shouldAnimate;

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buttonContainerHeight = 90;
        self.distanceFromBottom = -30;
        self.leftPanelColor = UIColor.blueColor;
        self.rightPanelColor = UIColor.redColor;
        self.shouldAnimate = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpButtonContainerView];
}

-(void) setUpUI{
    FeedViewController* feedVc = [[FeedViewController alloc]init];
    CameraViewController* cameraVc = [[CameraViewController alloc]init];
    ExploreViewController* exploreVc = [[ExploreViewController alloc]init];
    
    NSArray<UIViewController*>* viewControllers = @[feedVc, cameraVc, exploreVc];
    
    self.scrollView = [ScrollViewHelper   makeHorizontalScrollViewWithViewControllers:viewControllers withParentViewController:self];
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

//MARK:- Buttons Delegate
- (void)backToCamerea {
    
}

- (void)scrollToPosition:(PanelButtonPosition)posiiton {
    
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
