//
//  RootViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import <Firebase/Firebase.h>
#import "RootViewController.h"
#import "CartViewController.h"
#import "WelcomeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpLogoutNavigationItem];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"tabBarDidAppear" object:nil]];

    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
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

- (void)setUpLogoutNavigationItem{
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutButtonPressed)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)logoutButtonPressed{
    [[FIRAuth auth] signOut:nil];
    WelcomeViewController* vc = [[WelcomeViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
