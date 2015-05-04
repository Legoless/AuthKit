//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKOAuth.h"

@interface AKFacebookClient : AKOAuthClient

/*!
 *  Auto updates Facebook profile
 */
@property (nonatomic, assign) BOOL shouldAutoUpdateProfile;
- (BOOL)shouldAutoUpdateProfile UNAVAILABLE_ATTRIBUTE;

/*!
 * When initializing Facebook client, we define basic "Read" permissions.
 */
- (instancetype)initWithPermissions:(NSArray *)permissions;

/*!
 * Re-logins with additional permissions if required (write permissions)
 */
- (void)loginWithWritePermissions:(NSArray *)permissions success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end