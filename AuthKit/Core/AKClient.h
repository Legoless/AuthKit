/*!
 * Most used string constants
 */
extern NSString *const AKUsername;
extern NSString *const AKPassword;
extern NSString *const AKServerURL;

typedef void (^AKSuccessBlock)(id loginDetails);
typedef void (^AKFailureBlock)(id responseObject, NSError* error);

@interface AKClient : NSObject

/*!
 * Contains parameters which are needed to access the API
 */
@property (nonatomic, readonly) NSDictionary* accessParameters;
@property (nonatomic, readonly) NSURL* baseURL;

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
- (void)loginWithDetails:(NSDictionary *)details success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

/*!
 * In most cases, this API is used to login. But certain API's also require a second password
 * or additional generated token.
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;
@end