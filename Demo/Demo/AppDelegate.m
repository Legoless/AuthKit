//
//  AppDelegate.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AKClientManager.h>

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[AKClientManager sharedManager] setupWithLaunchOptions:launchOptions];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[AKClientManager sharedManager] handleDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[AKClientManager sharedManager] handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
