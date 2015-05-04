//
// Created by Dal Rupnik on 20/04/15.
//

#import "AKOAuth.h"

@interface AKTwitterClient : AKOAuthClient

- (instancetype)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;

@end