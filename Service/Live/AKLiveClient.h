//
//  Created by Dal Rupnik on 03/05/15.
//

#import "AKClient.h"
#import "AKLoginSource.h"
#import "AKOAuthSource.h"

@interface AKLiveClient : AKClient <AKOAuthSource, AKLoginSource>

- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end