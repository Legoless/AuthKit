//
// Created by Dal Rupnik on 23/03/15.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AKFacebookClient.h"

@interface AKFacebookClient ()

/*!
 *  Stores FBSDKLoginMechanic
 */
@property (nonatomic, strong) FBSDKLoginManager* loginManager;

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

@end

@implementation AKFacebookClient

#pragma mark - Getters and Setters

- (FBSDKLoginManager *)loginManager
{
    if (!_loginManager)
    {
        _loginManager = [[FBSDKLoginManager alloc] init];
    }
    
    return _loginManager;
}

- (void)setShouldAutoUpdateProfile:(BOOL)shouldAutoUpdateProfile
{
    [FBSDKProfile enableUpdatesOnAccessTokenChange:shouldAutoUpdateProfile];
}

- (AKSessionState)state
{
    FBSDKAccessToken* accessToken = [FBSDKAccessToken currentAccessToken];
    
    if (!accessToken)
    {
        return AKSessionStateClosed;
    }
    else
    {
        return AKSessionStateOpen;
    }
}

#pragma mark - Initializers

- (instancetype)initWithPermissions:(NSArray *)permissions
{
    return [self initWithAccessParameters:@{ AKScopes : permissions }];
}

#pragma mark - AKLoginSource

- (NSString *)sourceName
{
    return @"Facebook";
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
    
    [self.loginManager logInWithReadPermissions:self.accessParameters[AKScopes] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
        [self sessionStateChanged:result error:error];
    }];
}

- (void)loginWithWritePermissions:(NSArray *)permissions success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    [self.loginManager logInWithPublishPermissions:permissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
        [self sessionStateChanged:result error:error];
    }];
}

- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.loginManager logOut];
    
    if (success)
    {
        success (nil);
    }
}

- (void)sessionStateChanged:(FBSDKLoginManagerLoginResult *)loginResult error:(NSError *)error
{
    //
    // Get session state
    //

    AKSessionState sessionState = self.state;
    
    if (error)
    {
        sessionState = AKSessionStateClosedLoginFailed;
    }
    
    if (self.sessionChangedHandler)
    {
        self.sessionChangedHandler(sessionState, error);
    }

    // If the session was opened successfully
    if (error)
    {
        if (self.failureBlock)
        {
            self.failureBlock (nil, error);
            
            self.successBlock = nil;
            self.failureBlock = nil;
        }
    }
    else if (self.successBlock)
    {
        self.successBlock(loginResult);
        
        self.successBlock = nil;
        
        self.failureBlock = nil;
    }
}

@end