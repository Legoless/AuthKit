//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AuthKit.h>
#import <AuthKit/AKAuthViewController.h>

#import "ViewController.h"

@interface ViewController () <AKAuthViewControllerDelegate>

@property (nonatomic, strong) AKGitHubClient* gitHubClient;
@property (nonatomic, strong) AKCrashlyticsClient* crashlyticsClient;

@property (nonatomic, strong) AKAuthViewController *authVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.gitHubClient = [[AKGitHubClient alloc] initWithClientID:@"<YOUR_CLIENT_ID>" clientSecret:@"<YOUR_CLIENT_SECRET>" scopes:@[ AKGitHubScopeUser, AKGitHubScopeRepo ] note:@"Test"];
    
    /*[self.gitHubClient loginWithUsername:@"<USERNAME>" password:@"<PASSWORD>" success:^(id loginDetails)
     {
     NSLog(@"SUCCESS! %@", loginDetails);
     
     NSLog(@"TOKEN: %@", self.gitHubClient.accessToken);
     }
     failure:^(id responseObject, NSError *error)
     {
     NSLog(@"ERROR: %@", error);
     }];*/
    
    self.crashlyticsClient = [[AKCrashlyticsClient alloc] initWithDeveloperToken:@"<DEVELOPER_TOKEN>"];
    
    /*[self.crashlyticsClient loginWithUsername:@"<USERNAME>" password:@"<PASSWORD>" success:^(id loginDetails)
     {
     NSLog(@"SUCCESS! %@", loginDetails);
     
     NSLog(@"TOKEN: %@", self.crashlyticsClient.accessToken);
     }
     failure:^(id responseObject, NSError *error)
     {
     NSLog(@"ERROR: %@", error);
     }];*/

    self.authVC = [[AKAuthViewController alloc] initWithLoginSources:@[ self.gitHubClient, self.crashlyticsClient ]];
    self.authVC.delegate = self;
    self.authVC.headerImageView.image = [UIImage imageNamed:@"lock-icon"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.authVC)
    {
        [self presentViewController:self.authVC animated:YES completion:nil];
    }
}

- (IBAction)loginAuthKitButtonTap:(UIButton *)sender
{
    AKLiveClient* client = [[AKLiveClient alloc] initWithClientId:@"<CLIENT_ID>"];
    
    [client loginWithSuccess:^(id user)
    {
        
    }
    failure:^(id responseObject, NSError *error)
    {
        
    }];
    
    //AKTwitterClient *client = [[AKTwitterClient alloc] initWithAccessParameters:@{ AKServiceKey : @"<TWITTER_CONSUMER_KEY>", AKServiceSecret : @"<TWITTER_CONSUMER_SECRET>" }];

    /*
    AKLinkedInClient *client = [[AKLinkedInClient alloc] initWithAccessParameters:@{ AKServiceKey : @"<LINKEDIN_API_KEY", AKServiceSecret : @"<LINKEDIN_CONSUMER_SECRET>", AKScopes : @[ @"r_contactinfo", @"r_fullprofile" ] }];
    [client loginWithSuccess:^(id user) {
        NSLog(@"LinkedIn user: %@", user);
    } failure:^(id responseObject, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    return;
    [self presentViewController:self.authVC animated:YES completion:nil];*/
}

#pragma mark - AKAuthViewControllerDelegate

- (void)authViewControllerDidFinish:(id)authViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
