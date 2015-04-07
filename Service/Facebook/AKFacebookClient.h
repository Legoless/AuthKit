//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKClient.h"
#import "AKOAuthSource.h"
#import "AKLoginSource.h"

@interface AKFacebookClient : AKClient <AKLoginSource>

/*!
 * When initializing Facebook client, we define basic "Read" permissions.
 */
- (instancetype)initWithPermissions:(NSArray *)permissions;

/*!
 * Re-logins with additional permissions if required (write permissions)
 */
- (void)loginWithWritePermissions:(NSArray *)permissions success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end