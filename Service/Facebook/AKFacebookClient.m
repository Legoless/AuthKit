//
// Created by Dal Rupnik on 23/03/15.
//

#import <FacebookSDK/FacebookSDK.h>
#import "AKFacebookClient.h"

@interface AKFacebookClient ()

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

#pragma mark - AKOAuthSource

- (void)login
{
    [FBSession openActiveSessionWithReadPermissions:self.accessParameters[AKScopes] allowLoginUI:YES completionHandler:
                                          ^(FBSession *session, FBSessionState state, NSError *error)
    {
        [self sessionStateChanged:session state:state error:error];
    }];
}

- (void)loginWithPermissions:(NSArray *)permissions
{
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
    if (error && state != FBSessionStateOpen)
    {
        [FBSession.activeSession closeAndClearTokenInformation];

        return;
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