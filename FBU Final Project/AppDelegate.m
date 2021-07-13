//
//  AppDelegate.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

@import Firebase;
#import "AppDelegate.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    return YES;
}

@end
