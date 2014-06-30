#import "AKGitHubClient.h"

NSString *const AKGitHubClientID = @"kAKGitHubClientIDKey";
NSString *const AKGitHubClientSecret = @"kAKGitHubClientSecretKey";
NSString *const AKGitHubSecondPassword = @"kAKGitHubSecondPasswordKey";

@interface AKGitHubClient ()

@end

@implementation AKClient

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
    }
    
    return self;
}

- (void)loginWithDetails:(NSDictionary *)details success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure
{
    [NSException raise:@"Not implemented exception" format:@"loginWithDetails method not implemented in %@", [self class]];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure
{
    [self loginWithDetails:@{ AKUsername : username, AKPassword : password } success:success failure:failure];
}

@end