//
//  CLClient.m
//  DTrack
//
//  Created by Dal Rupnik on 22/07/14.
//  Copyright (c) 2014 D·Labs d.o.o. All rights reserved.
//

#import "AKCrashlyticsClient.h"

#import "AKCrashlyticsConstants.h"

#import "AKCrashlyticsUser.h"

@interface AKCrashlyticsClient ()

@property (nonatomic, strong, readwrite) NSString* developerToken;

@end

@implementation AKCrashlyticsClient

- (void)setAccessToken:(NSString *)accessToken
{
    _accessToken = accessToken;
    
    [self.manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"X-CRASHLYTICS-ACCESS-TOKEN"];
}

- (id)initWithDeveloperToken:(NSString *)developerToken
{
    return [self initWithAccessParameters:@{ AKCrashlyticsDeveloperToken : developerToken }];
}

- (id)initWithDeveloperToken:(NSString *)developerToken accessToken:(NSString *)accessToken
{
    return [self initWithAccessParameters:@{ AKCrashlyticsDeveloperToken : developerToken, AKAccessToken : accessToken }];
}

- (id)initWithAccessParameters:(NSDictionary *)parameters
{
    //
    // Set default server URL as parameter
    //
    if (!parameters[AKServerURL])
    {
        NSMutableDictionary *params = [parameters mutableCopy];
        
        params[AKServerURL] = AKCrashlyticsServerDefaultURL;
        
        parameters = [params copy];
    }
    
    self = [super initWithAccessParameters:parameters];
    
    if (self)
    {
        //
        // Check for must have parameters
        //
        
        if (!parameters[AKCrashlyticsDeveloperToken])
        {
            return nil;
        }

        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        self.developerToken = parameters[AKCrashlyticsDeveloperToken];
        
        [self.manager.requestSerializer setValue:self.developerToken forHTTPHeaderField:@"X-CRASHLYTICS-DEVELOPER-TOKEN"];
        
        //
        // Use access token as default parameter
        //
        if ([parameters[AKAccessToken] length])
        {
            self.accessToken = parameters[AKAccessToken];
            
            [self.manager.requestSerializer setValue:self.accessToken forHTTPHeaderField:@"X-CRASHLYTICS-ACCESS-TOKEN"];
        }
    }
    
    return self;
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.manager POST:@"session" parameters:@{ @"email" : details[AKUsername], @"password" : details[AKPassword] } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error;
        
        AKCrashlyticsUser* user = [[AKCrashlyticsUser alloc] initWithDictionary:responseObject error:&error];
        
        if (user && success)
        {
            [self.manager.requestSerializer setValue:user.token forHTTPHeaderField:@"X-CRASHLYTICS-ACCESS-TOKEN"];
            
            self.accessToken = user.token;
            
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
    AFHTTPRequestOperationManager *manager = [self.manager copy];
    
    if (self.accessToken)
    {
        //
        // This sets the request serializer to OAuth token, so we can do requests
        //
        [manager.requestSerializer setValue:self.accessToken forHTTPHeaderField:@"X-CRASHLYTICS-ACCESS-TOKEN"];
    }
    
    if (self.developerToken)
    {
        //
        // This sets the request serializer to OAuth token, so we can do requests
        //
        [manager.requestSerializer setValue:self.developerToken forHTTPHeaderField:@"X-CRASHLYTICS-DEVELOPER-TOKEN"];
    }
    
    return manager;
}

@end
