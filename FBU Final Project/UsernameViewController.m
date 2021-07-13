//
//  UsernameViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "UsernameViewController.h"
#import "TabBarController.h"
#import "User.h"

@interface UsernameViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation UsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];

}

- (void) setUpUI{
    self.textField = [[UITextField alloc]init];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.textField];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.textField.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant:16],
        [self.textField.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
        [self.textField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.textField.heightAnchor constraintEqualToConstant:50]
    ]];
    
    UIButton *continueButton = [[UIButton alloc]init];
    continueButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:continueButton];
    [continueButton addTarget:self action:@selector(continueButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint activateConstraints: @[
        [continueButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:16],
        [continueButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
        [continueButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
        [continueButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void) continueButtonPressed{
    if (self.textField.text == nil) { return; }
    
    User* user = [[User alloc]init];
    user.uid = [FIRAuth auth].currentUser.uid;
    user.username = self.textField.text;
    [user saveInBackgroundAtDefaultDirectoryWithCompletion:^(NSError * _Nullable error) {
        [User setSharedInstance:user];
        TabBarController *tabBarController = [[TabBarController alloc]init];
        tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:tabBarController animated:YES completion:nil];
    }];
}


@end
