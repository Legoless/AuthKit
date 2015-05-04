//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKOAuth.h"

@interface AKGoogleClient : AKOAuthClient

//
// Wrapper properties for Google Plus
//
@property (nonatomic, assign) BOOL shouldFetchGooglePlusUser;
@property (nonatomic, assign) BOOL shouldFetchGoogleUserEmail;
@property (nonatomic, assign) BOOL shouldFetchGoogleUserID;

- (instancetype)initWithClientId:(NSString *)clientId;
- (instancetype)initWithClientId:(NSString *)clientId scopes:(NSArray *)scopes;

@end