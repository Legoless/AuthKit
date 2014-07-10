//
//  AKClient.m
//  AuthKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "AKClient.h"

/*!
 * Most used string constants
 */
NSString *const AKUsername = @"kAKUsernameKey";
NSString *const AKPassword = @"kAKPasswordKey";
NSString *const AKServerURL = @"kAKServerURL";

@interface AKClient ()

@property (nonatomic, strong, readwrite) NSDictionary* accessParameters;
@property (nonatomic, strong, readwrite) NSURL* baseURL;

@end

@implementation AKClient

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
    }
    
    return self;
}

#pragma mark - Main methods

- (AFHTTPRequestOperationManager *)manager
{
    return [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
}

#pragma mark - Convenience methods


- (void)loginWithUsername:(NSString *)username password:(NSString *)password  success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:@{ AKUsername : username, AKPassword : password } success:success failure:failure];
}

#pragma mark - Abstract methods

//
// Methods below should be subclassed
//

- (BOOL)isAuthorized
{
    return NO;
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [NSException raise:@"Not implemented exception" format:@"loginWithDetails method not implemented in %@", [self class]];
}

- (void)userWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [NSException raise:@"Not implemented exception" format:@"userWithSuccess method not implemented in %@", [self class]];
}

@end