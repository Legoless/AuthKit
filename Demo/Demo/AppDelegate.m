//
//  AppDelegate.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AuthKit.h>

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //
    // Create login clients that we will use in the application
    //

    AKCrashlyticsClient *crashlytics = [[AKCrashlyticsClient alloc] initWithDeveloperToken:@"<DEVELOPER_TOKEN>"];
    
    AKFacebookClient *facebook = [[AKFacebookClient alloc] initWithPermissions:@[ AKFacebookPermissionPublicProfile, AKFacebookPermissionEmail ]];
    
    AKGitHubClient *github = [[AKGitHubClient alloc] initWithClientID:@"<CLIENT_ID>" clientSecret:@"<CLIENT_SECRET>" scopes:@[ AKGitHubScopeUser, AKGitHubScopeRepo ] note:@"Test"];
    
    AKGoogleClient *google = [[AKGoogleClient alloc] initWithClientId:@"<CLIENT_ID>" scopes:@[ AKGoogleScopeLogin, AKGoogleScopeProfile ]];
    
    AKLinkedInClient *linkedIn = [[AKLinkedInClient alloc] initWithClientId:@"<CLIENT_ID>" clientSecret:@"<CLIENT_SECRET>"];
    
    AKLiveClient *live = [[AKLiveClient alloc] initWithClientId:@"<CLIENT_ID>" scopes:@[ AKLiveScopeBasic, AKLiveScopeEmails ]];
    
    AKTwitterClient* twitter = [[AKTwitterClient alloc] initWithConsumerKey:@"<CONSUMER_KEY>" consumerSecret:@"<CONSUMER_SECRET>"];
    
    [[AKClientManager sharedManager] addLoginSources:@[ crashlytics, facebook, github, google, linkedIn, live, twitter ]];
    
    //
    // This sends launch options to all registered login sources that need them
    //
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
