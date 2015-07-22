//
//  AKGooglePlusClient.m
//  Pods
//
//  Created by Mišo Lubarda on 22/07/15.
//
//

#import "AKGooglePlusClient.h"

@interface AKGooglePlusClient ()<GPPSignInDelegate>

@property (nonatomic, strong) GPPSignIn *googlePlusService;

@end

@implementation AKGooglePlusClient

#pragma mark - Getters and Setters

- (GPPSignIn *)googlePlusService
{
    return (GPPSignIn *)self.googleService;
}

- (AKSessionState)state
{
    return (((GPPSignIn *)self.googleService).authentication != nil) ? AKSessionStateOpen : AKSessionStateClosed;
}

#pragma mark - Initializers

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super initWithClientId:clientId forGogleClientClass:[self class]];
    
    if (self)
    {
        self.googlePlusService.delegate = self;
    }
    
    return self;
}

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [super loginWithSuccess:success failure:failure];
    
    [self.googlePlusService authenticate];
}

#pragma mark - GPPSignInDelegate

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (auth && self.successBlock)
    {
        self.successBlock(auth);
    }
    else if (error && self.failureBlock)
    {
        self.failureBlock(nil, error);
    }
    else if (self.failureBlock)
    {
        self.failureBlock(nil, nil);
    }
    
    self.successBlock = nil;
    self.failureBlock = nil;
    
    if (self.sessionChangedHandler)
    {
        self.sessionChangedHandler(self.state, error);
    }
    
}

@end
