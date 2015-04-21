//
// Created by Dal Rupnik on 20/04/15.
//

#import <AuthKit/AKUser.h>

@interface AKOAuthUser : AKUser

/*!
 *  OAuth2 protocol requires both token and a secret
 */
@property (nonatomic, copy) NSString<Optional> *secret;

@end