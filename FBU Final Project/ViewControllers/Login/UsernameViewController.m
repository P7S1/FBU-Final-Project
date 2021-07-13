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
#import "DesignHelper.h"

@interface UsernameViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation UsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.title = @"Create a username";
}

- (void) setUpUI{
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.textField = [[UITextField alloc]init];
    self.textField.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.textField];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.textField.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant:16],
        [self.textField.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
        [self.textField.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.textField.heightAnchor constraintEqualToConstant:50]
    ]];
    
    UIButton *finishButton = [[UIButton alloc]init];
    finishButton.translatesAutoresizingMaskIntoConstraints = NO;
    finishButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [finishButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    [finishButton setTitle:@"Finish" forState:UIControlStateNormal];
    
    [self.view addSubview:finishButton];
    [finishButton addTarget:self action:@selector(finishButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint activateConstraints: @[
        [finishButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [finishButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
        [finishButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
        [finishButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void) finishButtonPressed{
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
