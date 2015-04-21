//
//  AKDefines.h
//  Pods
//
//  Created by Dal Rupnik on 26/03/15.
//
//

/*!
 * Most used string constants
 */
extern NSString *const AKUsername;
extern NSString *const AKPassword;
extern NSString *const AKAccessToken;   // Access token used to access the API
extern NSString *const AKServerURL;     // Server URL, some services have multiple server URL's
extern NSString *const AKScopes;        // Authentication scopes, such as permissions with Facebook
extern NSString *const AKServiceKey;    // Service Key string
extern NSString *const AKServiceSecret; // Service Secret string

//
// Session state
//
typedef NS_ENUM (NSUInteger, AKSessionState)
{
    AKSessionStateClosed,
    AKSessionStateClosedLoginFailed,
    AKSessionStateOpen
};

//
// Block definitions
//
typedef void (^AKSuccessBlock)(id user);
typedef void (^AKFailureBlock)(id responseObject, NSError* error);
typedef void (^AKSessionChangedBlock)(AKSessionState state, NSError* error);