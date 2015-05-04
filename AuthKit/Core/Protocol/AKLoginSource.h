//
//  Header.h
//  Pods
//
//  Created by Dal Rupnik on 24/07/14.
//
//

#import "AKDefines.h"

@protocol AKLoginSource <NSObject>

/*!
 * Returns YES, when AKClient is allowed to make authorized requests
 */
@property (nonatomic, readonly) AKSessionState state;

/*!
 * This method is the main login method that takes any number of parameters
 */
- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Once logged in, this method asynchronously returns user details for currently logged in user.
 */
- (void)userWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Returns login source name, such as Facebook, Twitter, ...
 */
- (NSString *)sourceName;

@optional

/*!
 * Logs user out of the service (if logined)
 */
- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end