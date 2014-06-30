/*!
 * Most used string constants
 */
extern NSString *const AKUsername;
extern NSString *const AKPassword;

@interface AKClient <NSObject>

/*!
 * Contains parameters which are needed to access the API
 */
@property (nonatomic, readonly) NSDictionary* accessParameters;

/*!
 * Designated initializer for any AuthKit client. Each API requires
 * certain parameters.
 *
 * @param NSDictionary API parameters
 */
- (id)initWithAccessParameters:(NSDictionary *)parameters;

/*!
 * Abstract login details, any number of parameters could be provided here.
 */
- (void)loginWithDetails:(NSDictionary *)details success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure;

/*!
 * In most cases, this API is used to login. But certain API's also require a second password
 * or additional generated token.
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(id loginDetails))success failure:(void (^)(NSError* error))failure;

@end