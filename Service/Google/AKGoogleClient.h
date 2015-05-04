//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKOAuth.h"

@interface AKGoogleClient : AKOAuthClient

- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end