//
//  AKPasswordLoginSource.h
//  Pods
//
//  Created by Dal Rupnik on 04/05/15.
//
//

#import "AKLoginSource.h"

@protocol AKPasswordLoginSource <AKLoginSource>

/*!
 * In most cases, this API is used to login. But certain API's also require a second password
 * or additional generated token.
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end