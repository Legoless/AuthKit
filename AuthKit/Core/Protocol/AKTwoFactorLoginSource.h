//
//  AKTwoFactorLoginSource.h
//  Pods
//
//  Created by Dal Rupnik on 04/05/15.
//
//

#import "AKPasswordLoginSource.h"

/*!
 *  Support Two Factor authentication for services like GitHub
 */
@protocol AKTwoFactorLoginSource <AKPasswordLoginSource>

- (void)loginWithUsername:(NSString *)username password:(NSString *)password secondPassword:(NSString *)secondPassword success:(AKSuccessBlock)success failure:(AKFailureBlock)failure;

@end