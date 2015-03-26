#import "AKCore.h"

@interface AKCrashlyticsClient : AKClient <AKLoginSource>

@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, readonly) NSString* developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken accessToken:(NSString *)accessToken;

@end
