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

@end

@implementation TabBarController

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

@end
