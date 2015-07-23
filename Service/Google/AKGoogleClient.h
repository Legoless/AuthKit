//
// Created by Dal Rupnik on 23/03/15.
//

#import <GooglePlus.h>
#import <GoogleSignIn/GoogleSignIn.h>

#import "AKOAuth.h"

@interface AKGoogleClient : AKOAuthClient

@property (nonatomic, strong, readonly) id googleService;

//
// Used to store pointers to blocks
//
@property (nonatomic, copy) AKSuccessBlock successBlock;
@property (nonatomic, copy) AKFailureBlock failureBlock;

- (instancetype)initWithClientId:(NSString *)clientId forGogleClientClass:(Class)clientClass scopes:(NSArray *)scopes;

@end
