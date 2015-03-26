//
// Created by Dal Rupnik on 24/03/15.
//

#import <Foundation/Foundation.h>
#import "AKClient.h"

@protocol AKOAuthSource <NSObject>

@required

/*!
 * Starts OAuth login process with a block based API
 */
- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Should usually be run in app delegate
 */

- (void)handleDidBecomeActive;

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end