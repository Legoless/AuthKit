//
//  AKClient.h
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AKLoginSource.h"
#import "AKDefines.h"

@class AKUser;
@class AFHTTPRequestOperationManager;

/*!
 * Main AuthKit class to connect to API
 */
@interface AKClient : NSObject <AKLoginSource>

/*!
 * Will be called each time session state has changed
 */
@property (nonatomic, copy) AKSessionChangedBlock sessionChangedHandler;

/*!
 * AFNetworking operation manager used by the class
 *
 * Note: Use managerCopy if you wish to change the parameters,
 *       it is exposed only for subclassing.
 *
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager* manager;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

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
@property (nonatomic, readonly) AKSessionState state;

/*!
 *  Access Token after successful login, each subclass must handle this separately
 */
@property (nonatomic, readonly) NSString* accessToken;

/*!
 * Designated initializer for any AuthKit client. Each API requires
 * certain parameters.
 *
 * @param NSDictionary API parameters
 */
- (instancetype)initWithAccessParameters:(NSDictionary *)parameters;

/*!
 * Returns new instance of connection manager configured to work with the API, usually AFNetworking
 * AFHTTPRequestOperationManager. This enables AKClient subclasses to expose direct working with APIs.
 */
- (AFHTTPRequestOperationManager *)managerCopy;

/*!
 * Returns new instance of connection manager configured to work with the API, usually AFNetworking
 * AFHTTPSessionManager. This enables AKClient subclasses to expose directly connecting to service APIs.
 */
- (AFHTTPSessionManager *)sessionManagerCopy;

@end