//
//  AKGitHubClient.h
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AKCore.h"

@interface AKGitHubClient : AKClient <AKLoginSource>

/*!
 * Initializes GitHub Auth Client with ClientID and ClientSecret with scopes
 */
- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note noteURL:(NSString *)noteURL serverURL:(NSString *)serverURL;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password secondPassword:(NSString *)secondPassword success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end
