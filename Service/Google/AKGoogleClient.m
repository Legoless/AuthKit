//
// Created by Dal Rupnik on 23/03/15.
//

#import <GooglePlus.h>
#import "AKGoogleClient.h"

@interface AKGoogleClient () <GPPSignInDelegate>

@property (nonatomic, strong) GPPSignIn *googleService;

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

@end

@implementation AKGoogleClient

#pragma mark - Getters and Setters

- (AKSessionState)state
{
    return (self.googleService.authentication != nil) ? AKSessionStateOpen : AKSessionStateClosed;
}

#pragma mark - Initializers

- (instancetype)initWithAccessParameters:(NSDictionary *)parameters
{
    self = [super initWithAccessParameters:parameters];

    if (self)
    {
        self.googleService = [GPPSignIn sharedInstance];

        self.googleService.clientID = self.accessParameters[AKServiceKey];

        if ([self.accessParameters[AKScopes] isKindOfClass:[NSArray class]])
        {
            self.googleService.scopes = self.accessParameters[AKScopes];
        }

        self.googleService.delegate = self;
        
        self.googleService.shouldFetchGooglePlusUser = YES;
        self.googleService.shouldFetchGoogleUserEmail = YES;
        self.googleService.shouldFetchGoogleUserID = YES;
    }

    return self;
}

- (instancetype)initWithClientId:(NSString *)clientId
{
    return [self initWithClientId:clientId scopes:nil];
}

- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    if (!clientId.length)
    {
        [[NSException exceptionWithName:@"ClientIdCannotBeEmpty" reason:@"Empty Client Id was provided" userInfo:nil] raise];
    }

    parameters[AKServiceKey] = clientId;

    if (scopes.count)
    {
        parameters[AKScopes] = scopes;
    }

    return [self initWithAccessParameters:parameters];
}

#pragma mark - AKLoginSource

- (NSString *)sourceName
{
    return @"Google";
}

#pragma mark - AKClient

- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.googleService signOut];
}

#pragma mark - AKOAuthSource

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:nil success:success failure:failure];
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;

    [self.googleService authenticate];
}

- (void)setup
{
    [self.googleService trySilentAuthentication];
}

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
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