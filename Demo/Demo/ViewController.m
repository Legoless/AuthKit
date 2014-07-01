//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AKGitHub.h>

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AKGitHubClient* client;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.client = [[AKGitHubClient alloc] initWithClientID:@"<YOUR_CLIENT_ID>" clientSecret:@"<YOUR_CLIENT_SECRET>" scopes:@[ AKGitHubScopeUser, AKGitHubScopeRepo ] note:@"Test"];
    
    [self.client loginWithUsername:@"<USERNAME>" password:@"<PASSWORD>" success:^(id loginDetails)
    {
        NSLog(@"SUCCESS! %@", loginDetails);
        
        NSLog(@"TOKEN: %@", self.client.accessToken);
    }
    failure:^(id responseObject, NSError *error)
    {
        NSLog(@"ERROR: %@", error);
    }];
}
@end
