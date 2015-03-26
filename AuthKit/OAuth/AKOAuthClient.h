//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKClient.h"
#import "AKOAuthSource.h"

@interface AKOAuthClient : AKClient <AKOAuthSource>

- (BOOL)handleApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end