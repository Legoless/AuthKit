#import "AKCore.h"

@interface AKCrashlyticsClient : AKClient <AKLoginSource>

@property (nonatomic, readonly) NSString* developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken accessToken:(NSString *)accessToken;

@end
