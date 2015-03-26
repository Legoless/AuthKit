//
// Created by Dal Rupnik on 23/03/15.
//

#import <FacebookSDK/FacebookSDK.h>
#import "AKFacebookClient.h"

@interface AKFacebookClient ()

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

@end

@implementation AKFacebookClient

#pragma mark - Getters and Setters

- (AKSessionState)state
{
    FBSession *session = [FBSession activeSession];

    return [self sessionStateForFacebookSession:session];
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
    
    [FBSession openActiveSessionWithReadPermissions:self.accessParameters[AKScopes] allowLoginUI:YES completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error)
    {
        [self sessionStateChanged:session state:state error:error];
    }];
}

- (void)loginWithWritePermissions:(NSArray *)permissions success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:self.defaultAudience allowLoginUI:YES completionHandler:
            ^(FBSession *session, FBSessionState state, NSError *error)
    {
        [self sessionStateChanged:session state:state error:error];
    }];
}

- (void)setup
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:self.accessParameters[AKScopes] allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
        {
            // Handler for session state changes
            // Call this method EACH time the session state changes,
            //  NOT just when the session open
            [self sessionStateChanged:session state:state error:error];
        }];
    }
}

- (void)handleDidBecomeActive
{
    [FBAppCall handleDidBecomeActive];
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    //
    // Get session state
    //

    AKSessionState sessionState = [self sessionStateForFacebookSession:session];

    if (self.sessionChangedHandler)
    {
        self.sessionChangedHandler(sessionState, error);
    }

    // If the session was opened successfully
    // If the session was opened successfully
    if (error && state != FBSessionStateOpen)
    {
        [FBSession.activeSession closeAndClearTokenInformation];
        
        if (self.failureBlock)
        {
            self.failureBlock (nil, error);
            
            self.successBlock = nil;
            self.failureBlock = nil;
        }
    }
    else if ( (state == FBSessionStateOpen || state == FBSessionStateOpenTokenExtended) && (self.successBlock) )
    {
        self.successBlock(session);
        
        self.failureBlock = nil;
    }
}

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}


#pragma mark - Helper methods

- (AKSessionState)sessionStateForFacebookSession:(FBSession *)session
{
    if (session.state == FBSessionStateClosedLoginFailed)
    {
        return AKSessionStateClosedLoginFailed;
    }
    else if (session.state == FBSessionStateOpen || session.state == FBSessionStateOpenTokenExtended)
    {
        return AKSessionStateOpen;
    }

    return AKSessionStateClosed;
}

@end