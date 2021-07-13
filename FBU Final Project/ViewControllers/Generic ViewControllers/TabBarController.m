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

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FeedViewController* feedVc = [[FeedViewController alloc]init];
    CameraViewController* cameraVc = [[CameraViewController alloc]init];
    ExploreViewController* exploreVc = [[ExploreViewController alloc]init];
    
    self.viewControllers = @[feedVc, cameraVc, exploreVc];
}

@end
