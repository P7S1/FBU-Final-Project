//
//  SceneDelegate.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import <FirebaseAuth/FirebaseAuth.h>
#import "SceneDelegate.h"
#import "WelcomeViewController.h"
#import "TabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.windowScene = (UIWindowScene *)scene;
    
    if ([FIRAuth auth].currentUser){
        self.window.rootViewController = [[TabBarController alloc]init];
    }else{
        WelcomeViewController *welcomeVc = [[WelcomeViewController alloc]init];
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:welcomeVc];;
    }
    
    //Doing this so SVProgresHUD doesn't crash
    UIApplication.sharedApplication.delegate.self.window = self.window;
    
    [self.window makeKeyAndVisible];
}

@end
