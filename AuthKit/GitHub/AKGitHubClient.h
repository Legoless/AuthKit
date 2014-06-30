#import "AKClient.h"

@interface AKGitHubClient <NSObject>

/*!
 * GitHub Access Token after successful login
 */
@property (nonatomic, readonly) NSString* accessToken;

/*!
 * Initializes GitHub Auth Client with ClientID and ClientSecret with scopes
 */
- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret scopes:(NSArray *)scopes note:(NSString *)note noteURL:(NSString *)noteURL;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password secondPassword:(NSString *)password success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure;

- (void)loginWithPasswordToken:(NSString *)passwordToken success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure;

- (void)loginWithPasswordToken:(NSString *)passwordToken secondPassword:(NSString *)password success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure;


@end