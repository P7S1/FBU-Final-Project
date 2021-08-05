//
//  LoginViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import "WelcomeViewController.h"
#import "EnterPhoneNumberViewController.h"
#import "DesignHelper.h"
#import "BasicButton.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    BasicButton* continueWithPhoneNumberButton = [[BasicButton alloc]init];
    continueWithPhoneNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
    [continueWithPhoneNumberButton setTitle:@"Continue With Phone" forState:UIControlStateNormal];
    continueWithPhoneNumberButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [continueWithPhoneNumberButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    
    [self.view addSubview:continueWithPhoneNumberButton];
    
    [NSLayoutConstraint activateConstraints:@[
            [continueWithPhoneNumberButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
            [continueWithPhoneNumberButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
            [continueWithPhoneNumberButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-32],
            [continueWithPhoneNumberButton.heightAnchor constraintEqualToConstant:50]
    ]];
    
    [continueWithPhoneNumberButton addTarget:self action:@selector(continueWithPhoneNumberButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:50 weight:UIFontWeightHeavy];
    titleLabel.text = @"Cornerstore";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16.0],
        [titleLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16.0],
        [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)continueWithPhoneNumberButtonPressed{
    EnterPhoneNumberViewController *vc = [[EnterPhoneNumberViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
