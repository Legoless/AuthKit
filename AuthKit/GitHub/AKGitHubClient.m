//
//  AKGitHubClient.m
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AKGitHubLogin.h"
#import "AKGitHubUser.h"

#import "AKGitHubConstants.h"

#import "AKGitHubClient.h"

@interface AKGitHubClient ()

@property (nonatomic, strong, readwrite) NSString* accessToken;

@end

@implementation AKGitHubClient

- (BOOL)isAuthorized
{
    return ([self.accessToken length] > 0);
}

- (id)initWithAccessParameters:(NSDictionary *)parameters
{
    //
    // Set default server URL as parameter
    //
    if (!parameters[AKServerURL])
    {
        NSMutableDictionary *params = [parameters mutableCopy];
        
        params[AKServerURL] = AKGitHubServerDefaultURL;
        
        parameters = [params copy];
    }
    
    self = [super initWithAccessParameters:parameters];
    
    if (self)
    {
        //
        // Check for must have parameters
        //
        if (( (parameters[AKGitHubClientID] == nil) || (parameters[AKGitHubClientSecret] == nil) || ([parameters[AKGitHubScope] count] == 0) ) && (![parameters[AKAccessToken] length]) )
        {
            return nil;
        }

        //
        // Use access token as default parameter
        //
        if ([parameters[AKAccessToken] length])
        {
            self.accessToken = parameters[AKAccessToken];
        }
    }
    
    return self;
}

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note
{
    return [self initWithClientID:clientID clientSecret:clientSecret scopes:scopes note:note noteURL:nil serverURL:nil];
}

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note noteURL:(NSString *)noteURL serverURL:(NSString *)serverURL
{
    NSMutableDictionary* parameters = [@{ AKGitHubClientID : clientID, AKGitHubClientSecret : clientSecret, AKGitHubScope : scopes, AKGitHubNote : note } mutableCopy];
    
    if ([noteURL length])
    {
        parameters[AKGitHubNoteURL] = noteURL;
    }
    
    if ([serverURL length])
    {
        parameters[AKServerURL] = serverURL;
    }
    
    return [self initWithAccessParameters:[parameters copy]];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password secondPassword:(NSString *)secondPassword success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    NSDictionary* parameters = @{ AKUsername : username, AKPassword : password, AKGitHubSecondPassword : secondPassword };
    
    [self loginWithDetails:parameters success:success failure:failure];
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    if ( (details[AKUsername] != nil) && (details[AKPassword] != nil) )
    {
        [self loginWithUser:details success:success failure:failure];
    }
    else
    {
        [NSException raise:@"Invalid or insufficient parameters." format:@"Check which parameters you provide and if they are not nil."];
    }
}

- (void)loginWithUser:(NSDictionary *)parameters success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    //
    // Handles second password
    //
    
    if (parameters[AKGitHubSecondPassword])
    {
        [self.manager.requestSerializer setValue:parameters[AKGitHubSecondPassword] forHTTPHeaderField:@"X-GitHub-OTP"];
    }
    else
    {
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    // Use credential
    [self.manager.requestSerializer setAuthorizationHeaderFieldWithUsername:parameters[AKUsername] password:parameters[AKPassword]];
    
    //
    // Login with specific user, we use Basic Authentication to create OAuth2 Token.
    //
    
    [self executeLoginRequest:[self buildAccessParameters] success:success failure:failure];
}

- (NSDictionary *)buildAccessParameters
{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = self.accessParameters[AKGitHubClientID];
    params[@"client_secret"] = self.accessParameters[AKGitHubClientSecret];
    
    params[@"note"] = self.accessParameters[AKGitHubNote];
    
    if (self.accessParameters[AKGitHubScope])
    {
        params[@"scopes"] = self.accessParameters[AKGitHubScope];
    }
    
    if (self.accessParameters[AKGitHubNoteURL])
    {
        params[@"note_url"] = self.accessParameters[AKGitHubNoteURL];
    }

    return params;
}

- (void)executeLoginRequest:(NSDictionary *)parameters success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.manager POST:@"authorizations" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;

        AKGitHubLogin* login = [[AKGitHubLogin alloc] initWithDictionary:responseObject error:&error];

        if (login && success)
        {
            self.accessToken = [login.token copy];
            
            //
            // This sets the request serializer to OAuth token, so we can do requests
            //
            [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"token %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
            
            success (login);
        }
        else if (error && failure)
        {
            failure (operation.responseObject ? operation.responseObject : operation.responseString, error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure (operation.responseObject ? operation.responseObject : operation.responseString, error);
        }
    }];
}

- (void)userWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.manager GET:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;
        
        AKGitHubUser* user = [[AKGitHubUser alloc] initWithDictionary:responseObject error:&error];
        
        if (user && success)
        {
            success(user);
        }
        else if (error && failure)
        {
            failure (responseObject, error);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failure)
        {
            failure (operation.responseObject ? operation.responseObject : operation.responseString, error);
        }
    }];
}

- (AFHTTPRequestOperationManager *)managerCopy
{
    //
    // Just copy the current manager here, should also contain all token information
    //
    
    AFHTTPRequestOperationManager *manager = [self.manager copy];

    if (self.accessToken)
    {
        //
        // This sets the request serializer to OAuth token, so we can do requests
        //
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"token %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
    }

    return manager;
}

@end
