//
//  Created by Dal Rupnik on 03/05/15.
//

#import "AKOAuth.h"

@interface AKLiveClient : AKOAuthClient
- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end