//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKClient.h"
#import "AKLoginSource.h"
#import "AKOAuthSource.h"

@interface AKGoogleClient : AKClient <AKOAuthSource, AKLoginSource>

//
// Wrapper properties for Google Plus
//
@property (nonatomic, assign) BOOL shouldFetchGooglePlusUser;
@property (nonatomic, assign) BOOL shouldFetchGoogleUserEmail;

- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end