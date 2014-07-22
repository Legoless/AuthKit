//
//  AKClient.h
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/*!
 * Most used string constants
 */
extern NSString *const AKUsername;
extern NSString *const AKPassword;
extern NSString *const AKAccessToken;
extern NSString *const AKServerURL;

typedef void (^AKSuccessBlock)(id details);
typedef void (^AKFailureBlock)(id responseObject, NSError* error);

@class AFHTTPRequestOperationManager;

@interface AKClient : NSObject

/*!
 * AFNetworking operation manager used by the class
 *
 * Note: Use managerCopy if you wish to change the parameters,
 *       it is exposed only for subclassing.
 *
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager* manager;

/*!
 * Contains parameters which are needed to access the API
 */
@property (nonatomic, readonly) NSDictionary* accessParameters;

/*!
 * Base URL of the API, usually corresponds to correct version
 */
@property (nonatomic, readonly) NSURL* baseURL;

/*!
 * Returns YES, when AKClient is allowed to make authorized requests
 */
@property (nonatomic, readonly) BOOL isAuthorized;

/*!
 * Designated initializer for any AuthKit client. Each API requires
 * certain parameters.
 *
 * @param NSDictionary API parameters
 */
- (id)initWithAccessParameters:(NSDictionary *)parameters;

/*!
 * Abstract login details, any number of parameters could be provided here.
 */
- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * In most cases, this API is used to login. But certain API's also require a second password
 * or additional generated token.
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Once logged in, this method returns default user details for currently logged in user.
 */
- (void)userWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * Returns new instance of connection manager configured to work with the API, usually AFNetworking
 * AFHTTPRequestOperationManager. This enables AKClient subclasses to expose direct working with APIs.
 */
- (AFHTTPRequestOperationManager *)managerCopy;

@end