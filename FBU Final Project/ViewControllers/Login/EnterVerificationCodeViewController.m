//
//  EnterVerificationCodeViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import "EnterVerificationCodeViewController.h"
#import "UsernameViewController.h"
#import "TabBarController.h"
#import "User.h"
#import "DesignHelper.h"
#import "BasicButton.h"

@interface EnterVerificationCodeViewController ()

@property (nonatomic, readwrite) FIRFirestore *db;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation EnterVerificationCodeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
    self.db = [FIRFirestore firestore];
    self.navigationItem.title = @"Enter Verification Code";
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
    
    BasicButton *continueButton = [[BasicButton alloc]init];
    continueButton.translatesAutoresizingMaskIntoConstraints = NO;
    continueButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [continueButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    
    [self.view addSubview:continueButton];
    [continueButton addTarget:self action:@selector(continueButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint activateConstraints: @[
        [continueButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [continueButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
        [continueButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
        [continueButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void) continueButtonPressed{
    if (self.textField.text == nil) { return; }
    
    NSString* verificationCodeString = self.textField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *verificationID = [defaults stringForKey:@"authVerificationID"];
    
    FIRAuthCredential *credential = [[FIRPhoneAuthProvider provider]
        credentialWithVerificationID:verificationID
                    verificationCode:verificationCodeString];
    
    [self signInWithCredential:credential];
}

- (void) signInWithCredential: (FIRAuthCredential*)credential{
    [[FIRAuth auth] signInWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"Signing in with auth credential error");
            NSLog(@"%@", error.localizedDescription);
        }else{
            //Sign in was successful :)
            NSString *documentPath = [@"users/" stringByAppendingString:[FIRAuth auth].currentUser.uid];
            [[self.db documentWithPath:documentPath] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
                
                if (error != nil){
                    NSLog(@"getting document error");
                    NSLog(@"%@", [error localizedDescription]);
                }else if (snapshot.exists){
                    User* user = [[User alloc]initWithDict:snapshot.data];
                    [User setSharedInstance:user];
                    
                    TabBarController* tabBarController = [[TabBarController alloc]init];
                    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:tabBarController animated:YES completion:nil];
                }else{
                    UsernameViewController *vc = [[UsernameViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }];
        }
    }];
}


@end
