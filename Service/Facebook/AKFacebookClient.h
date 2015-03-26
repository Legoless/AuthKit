//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKClient.h"
#import "AKOAuthSource.h"
#import "AKLoginSource.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AKFacebookClient : AKClient <AKOAuthSource, AKLoginSource>

@property (nonatomic, assign) FBSessionDefaultAudience defaultAudience;

/*!
 * When initializing Facebook client, we define basic "Read" permissions.
 */
- (instancetype)initWithPermissions:(NSArray *)permissions;

/*!
 * Re-logins with additional permissions if required (write permissions)
 */
- (void)loginWithPermissions:(NSArray *)permissions;

@end