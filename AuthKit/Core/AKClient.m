#import "AKClient.h"

/*!
 * Most used string constants
 */
NSString *const AKUsername = @"kAKUsernameKey";
NSString *const AKPassword = @"kAKPasswordKey";

@interface AKClient ()

@property (nonatomic, strong, readwrite) NSDictionary* accessParameters;

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
    [self loginWithDetails:@{ AKUsernameKey : username, AKPasswordKey : password } success:success failure:failure];
}

@end