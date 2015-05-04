//
//  AKPasswordClient.m
//  Pods
//
//  Created by Dal Rupnik on 04/05/15.
//
//

#import "AKPasswordClient.h"

@implementation AKPasswordClient

- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(AKSuccessBlock)success failure:(AKFailureBlock)failure
{
    [self loginWithDetails:@{ AKUsername : username, AKPassword : password } success:success failure:failure];
}

@end
