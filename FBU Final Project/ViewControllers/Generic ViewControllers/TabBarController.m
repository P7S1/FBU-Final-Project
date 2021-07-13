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
    feedVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage systemImageNamed:@"house"] tag:0];
    
    CameraViewController* cameraVc = [[CameraViewController alloc]init];
    cameraVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage systemImageNamed:@"plus.app"] tag:0];
    
    ExploreViewController* exploreVc = [[ExploreViewController alloc]init];
    exploreVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage systemImageNamed:@"magnifyingglass"] tag:0];
    
    self.viewControllers = @[feedVc, cameraVc, exploreVc];
}

@end
