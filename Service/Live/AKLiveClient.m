//
//  Created by Dal Rupnik on 03/05/15.
//

#import <LiveSDK/LiveConnectClient.h>
#import "AKLiveClient.h"
#import "AKLiveConstants.h"

@interface AKLiveClient () <LiveAuthDelegate>

@property (nonatomic, strong) LiveConnectClient* liveClient;

@property (nonatomic, assign) AKSessionState currentState;

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

@end

@implementation AKLiveClient

#pragma mark - Getters and Setters

- (AKSessionState)state
{
    return self.currentState;
}

#pragma mark - Initializers

- (instancetype)initWithAccessParameters:(NSDictionary *)parameters
{
    //
    // Set default server URL as parameter
    //
    if (!parameters[AKScopes])
    {
        NSMutableDictionary *params = [parameters mutableCopy];
        
        params[AKScopes] = @[ AKLiveScopeBasic, AKLiveScopeEmails, AKLiveScopeSignIn ];
        
        parameters = [params copy];
    }

    self = [super initWithAccessParameters:parameters];

    if (self)
    {
        self.liveClient = [[LiveConnectClient alloc] initWithClientId:self.accessParameters[AKServiceKey] scopes:self.accessParameters[AKScopes] delegate:self];
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
    return @"Live";
}

#pragma mark - AKClient

- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.currentState = AKSessionStateClosed;
    
    [self.liveClient logout];
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
    
    self.currentState = AKSessionStateClosed;

    [self.liveClient login:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
}

#pragma mark - LiveAuthDelegate

- (void)authFailed:(NSError *) error userState:(id)userState
{
    self.currentState = AKSessionStateClosedLoginFailed;
    
    if (self.failureBlock)
    {
        self.failureBlock(userState, error);
    }
    
    self.failureBlock = nil;
}

- (void)authCompleted:(LiveConnectSessionStatus)status session:(LiveConnectSession *)session userState:(id)userState
{
    self.currentState = AKSessionStateOpen;
    
    if (self.successBlock)
    {
        self.successBlock (session);
    }
    
    self.successBlock = nil;
}

@end