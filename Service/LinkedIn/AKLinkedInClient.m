//
// Created by Dal Rupnik on 23/03/15.
//

#import <IOSLinkedInAPI/LIALinkedInApplication.h>
#import <Haystack/NSString+Random.h>

#import "AKLinkedInClient.h"
#import "AKLinkedInConstants.h"
#import "LIALinkedInApplication.h"
#import "LIALinkedInHttpClient.h"
#import "AKLinkedInRequestSerializer.h"

@interface AKLinkedInClient ()

@property (nonatomic, strong) LIALinkedInApplication* linkedIn;
@property (nonatomic, strong) LIALinkedInHttpClient *linkedInClient;

@property (nonatomic, strong, readwrite) NSString* accessToken;

@end

@implementation AKLinkedInClient

@synthesize accessToken = _accessToken;

#pragma mark - Getters and Setters

- (LIALinkedInApplication *)linkedIn
{
    if (!_linkedIn)
    {
        _linkedIn = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.arvystate.net" clientId:self.accessParameters[AKServiceKey] clientSecret:self.accessParameters[AKServiceSecret] state:[NSString hs_randomAlphaNumericStringOfLength:10] grantedAccess:self.accessParameters[AKScopes]];
    }

    return _linkedIn;
}

- (LIALinkedInHttpClient *)linkedInClient
{
    if (!_linkedInClient)
    {
        _linkedInClient = [LIALinkedInHttpClient clientForApplication:self.linkedIn];
    }

    return _linkedInClient;
}

#pragma mark - Initializers

- (instancetype)initWithAccessParameters:(NSDictionary *)parameters
{
    //
    // Set default server URL as parameter
    //
    if (!parameters[AKServerURL])
    {
        NSMutableDictionary *params = [parameters mutableCopy];

        params[AKServerURL] = AKLinkedInServerDefaultURL;

        parameters = [params copy];
    }

    self = [super initWithAccessParameters:parameters];

    return self;
}

#pragma mark - AKLoginSource

- (NSString *)sourceName
{
    return @"LinkedIn";
}

#pragma mark - AKOAuthSource

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:nil success:success failure:failure];
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self.linkedInClient getAuthorizationCode:^(NSString *code) {
        [self.linkedInClient getAccessToken:code success:^(NSDictionary *dictionary)
        {
            self.accessToken = dictionary[@"access_token"];

            [self.manager GET:@"/v1/people/~" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
                if (success)
                {
                    success (result);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure)
                {
                    failure (operation.responseObject, error);
                }
            }];
        } failure:^(NSError *error) {
            if (failure)
            {
                failure (nil, error);
            }
        }];
    }
    cancel:^
    {
        if (failure)
        {
            failure (nil, nil);
        }
    }
    failure:^(NSError *error)
    {
        if (failure)
        {
            failure (nil, nil);
        }
    }];
}

- (AFHTTPRequestOperationManager *)manager
{
    NSURL* serverURL = [NSURL URLWithString:self.accessParameters[AKServerURL]];

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:serverURL];

    AKLinkedInRequestSerializer *serializer = [AKLinkedInRequestSerializer serializer];

    serializer.accessToken = self.accessToken;

    manager.requestSerializer = serializer;

    return manager;
}

@end