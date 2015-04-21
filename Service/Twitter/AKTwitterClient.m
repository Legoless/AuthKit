//
// Created by Dal Rupnik on 20/04/15.
//

#import <STTwitter/STTwitter.h>

#import "AKOAuthUser.h"

#import "AKTwitterClient.h"

@interface AKTwitterClient ()

@property (nonatomic, strong) STTwitterAPI *twitter;

@property (nonatomic, strong) id user;

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

@end

@implementation AKTwitterClient

#pragma mark - Getters and Setters

- (STTwitterAPI *)twitter
{
    if (!_twitter)
    {
        _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:self.accessParameters[AKServiceKey] consumerSecret:self.accessParameters[AKServiceSecret]];
    }

    return _twitter;
}

- (AKSessionState)state
{
    if ([self.user isKindOfClass:[AKOAuthUser class]])
    {
        return AKSessionStateOpen;
    }
    else if (self.user != nil)
    {
        return AKSessionStateClosedLoginFailed;
    }

    return AKSessionStateClosed;
}

#pragma mark - AKLoginSource

- (NSString *)sourceName
{
    return @"Twitter";
}

#pragma mark - AKOAuthSource

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:nil success:success failure:failure];
}

- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    self.user = nil;

    [self.twitter postReverseOAuthTokenRequest:^(NSString *authenticationHeader)
    {
        STTwitterAPI *twitterAPIOS = [STTwitterAPI twitterAPIOSWithFirstAccount];

        [twitterAPIOS verifyCredentialsWithSuccessBlock:^(NSString *username)
        {
            [twitterAPIOS postReverseAuthAccessTokenWithAuthenticationHeader:authenticationHeader successBlock:^(NSString *oAuthToken, NSString *oAuthTokenSecret, NSString *userID, NSString *screenName)
            {
                AKOAuthUser *user = [[AKOAuthUser alloc] init];
                user.name = screenName;
                user.token = oAuthToken;
                user.secret = oAuthTokenSecret;

                self.user = user;

                if (success)
                {
                    success(user);
                }
            }
            errorBlock:^(NSError *error)
            {
                self.user = [NSNull null];

                if (failure)
                {
                    failure (nil, error);
                }
            }];
        } errorBlock:^(NSError *error)
        {
            self.user = [NSNull null];

            if (failure)
            {
                failure (nil, error);
            }
        }];
    }
    errorBlock:^(NSError *error)
    {
        self.user = [NSNull null];

        if (failure)
        {
            failure (nil, error);
        }
    }];

    self.successBlock = success;
    self.failureBlock = failure;
}

@end