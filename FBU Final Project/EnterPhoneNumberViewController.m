//
//  EnterPhoneNumberViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import <FirebaseAuth/FirebaseAuth.h>
#import "EnterPhoneNumberViewController.h"
#import "EnterVerificationCodeViewController.h"

@interface EnterPhoneNumberViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation EnterPhoneNumberViewController

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
    
    NSString* phoneNumberString = self.textField.text;
    
    [[FIRPhoneAuthProvider provider] verifyPhoneNumber:phoneNumberString
                                            UIDelegate:nil
                                            completion:^(NSString * _Nullable verificationID, NSError * _Nullable error) {
      if (error) { return; }
      // Sign in using the verificationID and the code sent to the user
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:verificationID forKey:@"authVerificationID"];
        
        EnterVerificationCodeViewController* vc = [[EnterVerificationCodeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
@end
