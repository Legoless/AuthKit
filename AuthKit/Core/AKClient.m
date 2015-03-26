//
//  AKClient.m
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AKClient.h"



@interface AKClient ()

@property (nonatomic, strong, readwrite) NSDictionary* accessParameters;
@property (nonatomic, strong, readwrite) NSURL* baseURL;

@end

@implementation AKClient

#pragma mark - Getters and Setters

- (AKSessionState)state
{
    return AKSessionStateClosed;
}

#pragma mark - Initializers

- (id)init
{
    return [self initWithAccessParameters:nil];
}

- (id)initWithAccessParameters:(NSDictionary *)parameters
{
    self = [super init];
    
    if (self)
    {
        self.accessParameters = [parameters copy];
        
        if ([parameters[AKServerURL] isKindOfClass:[NSString class]])
        {
            self.baseURL = [NSURL URLWithString:parameters[AKServerURL]];
        }
        else if ([parameters[AKServerURL] isKindOfClass:[NSURL class]])
        {
            self.baseURL = parameters[AKServerURL];
        }
        
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    }
    
    return self;
}

#pragma mark - Main methods

- (AFHTTPRequestOperationManager *)managerCopy
{
    return [self.manager copy];
}

- (AFHTTPSessionManager *)sessionManagerCopy
{
    return [self.sessionManager copy];
}

#pragma mark - Convenience methods


- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:@{ AKUsername : username, AKPassword : password } success:success failure:failure];
}

#pragma mark - Abstract methods

//
// Methods below should be implemented in subclasses
//

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:nil success:success failure:failure];
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [NSException raise:@"Not implemented exception" format:@"loginWithDetails method not implemented in %@", [self class]];
}

- (void)userWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [NSException raise:@"Not implemented exception" format:@"userWithSuccess method not implemented in %@", [self class]];
}

- (void)logoutWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [NSException raise:@"Not implemented exception" format:@"logoutWithSuccess method not implemented in %@", [self class]];
}

@end