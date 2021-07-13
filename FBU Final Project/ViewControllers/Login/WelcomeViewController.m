//
//  LoginViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import "WelcomeViewController.h"
#import "EnterPhoneNumberViewController.h"
#import "DesignHelper.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIButton* continueWithPhoneNumberButton = [[UIButton alloc]init];
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
}

-(void)continueWithPhoneNumberButtonPressed{
    EnterPhoneNumberViewController *vc = [[EnterPhoneNumberViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
