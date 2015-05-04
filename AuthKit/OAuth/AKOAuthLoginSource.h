//
// Created by Dal Rupnik on 24/03/15.
//

#import <Foundation/Foundation.h>
#import "AKLoginSource.h"

@protocol AKOAuthLoginSource <AKLoginSource>

@optional

/*!
 * Starts OAuth login process with a block based API
 */
- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Methods below should be run when app delegate receives the messages
 */
- (void)setupWithLaunchOptions:(NSDictionary *)options;

- (void)handleDidBecomeActive;

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end