//
//  AKGoogleSignInClient.h
//  Pods
//
//  Created by Mišo Lubarda on 22/07/15.
//
//

#import "AKGoogleClient.h"

@interface AKGoogleSignInClient : AKGoogleClient

- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end
