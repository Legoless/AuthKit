//
//  AKGitHubClient.h
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AKClient.h"

@interface AKGitHubClient : AKClient

/*!
 * GitHub Access Token after successful login
 */
@property (nonatomic, readonly) NSString* accessToken;

/*!
 * Initializes GitHub Auth Client with ClientID and ClientSecret with scopes
 */
- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note noteURL:(NSString *)noteURL serverURL:(NSString *)serverURL;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password secondPassword:(NSString *)secondPassword success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end
