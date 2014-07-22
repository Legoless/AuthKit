//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AuthKit.h>

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AKGitHubClient* gitHubClient;
@property (nonatomic, strong) AKCrashlyticsClient* crashlyticsClient;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.gitHubClient = [[AKGitHubClient alloc] initWithClientID:@"<YOUR_CLIENT_ID>" clientSecret:@"<YOUR_CLIENT_SECRET>" scopes:@[ AKGitHubScopeUser, AKGitHubScopeRepo ] note:@"Test"];
    
    [self.gitHubClient loginWithUsername:@"<USERNAME>" password:@"<PASSWORD>" success:^(id loginDetails)
    {
        NSLog(@"SUCCESS! %@", loginDetails);
        
        NSLog(@"TOKEN: %@", self.gitHubClient.accessToken);
    }
    failure:^(id responseObject, NSError *error)
    {
        NSLog(@"ERROR: %@", error);
    }];
     
    self.crashlyticsClient = [[AKCrashlyticsClient alloc] initWithDeveloperToken:@"<DEVELOPER_TOKEN>"];
    
    [self.crashlyticsClient loginWithUsername:@"<USERNAME>" password:@"<PASSWORD>" success:^(id loginDetails)
    {
        NSLog(@"SUCCESS! %@", loginDetails);

        NSLog(@"TOKEN: %@", self.crashlyticsClient.accessToken);
    }
    failure:^(id responseObject, NSError *error)
    {
        NSLog(@"ERROR: %@", error);
    }];
}
@end
