//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKGoogleClient.h"
#import "AKGooglePlusClient.h"
#import "AKGoogleSignInClient.h"

@interface AKGoogleClient () <GIDSignInDelegate>

@property (nonatomic, strong, readwrite) id googleService;

@end

@implementation AKGoogleClient

#pragma mark - Getters and Setters

- (AKSessionState)state
{
    // Override this method to set state accordingly
}

#pragma mark - Initializers

- (instancetype)initWithAccessParameters:(NSDictionary *)parameters forGogleClientClass:(__unsafe_unretained Class)clientClass
{
    self = [super initWithAccessParameters:parameters];

    if (self)
    {
        if ([clientClass isSubclassOfClass:[AKGooglePlusClient class]])
        {
            GPPSignIn *googleService = [GPPSignIn sharedInstance];
            
            googleService.clientID = self.accessParameters[AKServiceKey];
            
            if ([self.accessParameters[AKScopes] isKindOfClass:[NSArray class]])
            {
                googleService.scopes = self.accessParameters[AKScopes];
            }
            
            googleService.shouldFetchGooglePlusUser = YES;
            googleService.shouldFetchGoogleUserEmail = YES;
            googleService.shouldFetchGoogleUserID = YES;
            
            self.googleService = googleService;
        }
        else if ([clientClass isSubclassOfClass:[AKGoogleSignInClient class]])
        {
            GIDSignIn *googleService = [GIDSignIn sharedInstance];
            
            googleService.clientID = self.accessParameters[AKServiceKey];
            
            if ([self.accessParameters[AKScopes] isKindOfClass:[NSArray class]])
            {
                googleService.scopes = self.accessParameters[AKScopes];
            }
            
            self.googleService = googleService;
        }
    }

    return self;
}

//- (instancetype)initWithClientId:(NSString *)clientId forGogleClientClass:(__unsafe_unretained Class)clientClass
//{
//    return [self initWithClientId:clientId forGogleClientClass:clientClass scopes:nil];
//}

- (instancetype)initWithClientId:(NSString *)clientId forGogleClientClass:(__unsafe_unretained Class)clientClass scopes:(NSArray *)scopes
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
    
    return [self initWithAccessParameters:parameters forGogleClientClass:clientClass];
}

#pragma mark - AKLoginSource

- (NSString *)sourceName
{
    return @"Google";
}

#pragma mark - AKClient

- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    // Both Goole logins use -singOut method
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
    
    // Override to continue login
}

/**
 *  Wasn't used anywhere
 */
//- (void)setup
//{
//    [self.googlePlusService trySilentAuthentication];
//}

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([self isKindOfClass:[AKGooglePlusClient class]])
    {
        return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    else if ([self isKindOfClass:[AKGoogleSignInClient class]])
    {
        return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return NO;
}



@end