//
//  LoginViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import "WelcomeViewController.h"
#import "EnterPhoneNumberViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    UIButton* continueWithPhoneNumberButton = [[UIButton alloc]init];
    continueWithPhoneNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:continueWithPhoneNumberButton];
    
    [NSLayoutConstraint activateConstraints:@[
            [continueWithPhoneNumberButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
            [continueWithPhoneNumberButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
            [continueWithPhoneNumberButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:16],
            [continueWithPhoneNumberButton.heightAnchor constraintEqualToConstant:50]
    ]];
    
    [continueWithPhoneNumberButton addTarget:self action:@selector(continueWithPhoneNumberButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)continueWithPhoneNumberButtonPressed{
    EnterPhoneNumberViewController *vc = [[EnterPhoneNumberViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
