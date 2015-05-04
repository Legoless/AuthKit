//
//  AKOAuthClient.m
//  Pods
//
//  Created by Dal Rupnik on 04/05/15.
//
//

#import "AKOAuthClient.h"

@implementation AKOAuthClient

- (void)loginWithSuccess:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:nil success:success failure:failure];
}

@end
