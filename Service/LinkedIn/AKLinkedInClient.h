//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKOAuth.h"

@interface AKLinkedInClient : AKOAuthClient

- (instancetype)initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret;

@end