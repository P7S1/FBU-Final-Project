//
//  RootViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"tabBarDidAppear" object:nil]];

    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    [self setUpCartNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"tabBarWillDisappear" object:nil]];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void)setUpCartNavigationItem{
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithImage:[UIImage systemImageNamed:@"cart"] style:UIBarButtonItemStyleDone target:self action:@selector(cartButtonPressed)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)cartButtonPressed{
    
}

@end
