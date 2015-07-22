//
//  AKGoogleSignInClient.m
//  Pods
//
//  Created by Mišo Lubarda on 22/07/15.
//
//

#import "AKGoogleSignInClient.h"

@interface AKGoogleSignInClient ()<GIDSignInDelegate, GIDSignInUIDelegate>

@property (nonatomic, strong) GIDSignIn *googleSignInService;

@end

@implementation AKGoogleSignInClient

#pragma mark - Getters and Setters

- (GIDSignIn *)googleSignInService
{
    return (GIDSignIn *)self.googleService;
}

- (AKSessionState)state
{
    return (self.googleSignInService.currentUser != nil) ? AKSessionStateOpen : AKSessionStateClosed;
}

#pragma mark - Initializers

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super initWithClientId:clientId forGogleClientClass:[self class]];
    if (self)
    {
        self.googleSignInService.delegate = self;
        self.googleSignInService.uiDelegate = self;
    }
    return self;
}

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [super loginWithSuccess:success failure:failure];
    
    [self.googleSignInService signIn];
}

#pragma mark - GIDSignInDelegate
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (user && self.successBlock)
    {
        self.successBlock(user);
    }
    else if (error && self.failureBlock)
    {
        self.failureBlock(nil, error);
    }
    
    self.successBlock = nil;
    self.failureBlock = nil;
    
    if (self.sessionChangedHandler)
    {
        self.sessionChangedHandler(self.state, error);
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    
}

#pragma mark - GIDSignInUIDelegate

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
