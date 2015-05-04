//
// Created by Dal Rupnik on 23/03/15.
//

@import UIKit;

#import "AKLoginSource.h"
#import "AKClient.h"
#import "AKOAuthLoginSource.h"

/*!
 * Manager of clients per application, supports multiple login sources
 */
@interface AKClientManager : NSObject

/*!
 * Singleton access to shared manager
 */
+ (instancetype)sharedManager;

/*!
 *  Registered login sources
 */
@property (nonatomic, readonly) NSArray* loginSources;

/*!
 * Returns registered login source by name
 */
- (id<AKLoginSource>)loginSourceWithName:(NSString *)name;

/*!
 * Returns login source by class
 */
- (id<AKLoginSource>)loginSourceWithClass:(Class)class;

/*!
 * Adds login source
 */
- (void)addLoginSource:(id<AKLoginSource>)source;

#pragma mark - AKOAuthLoginSource

/*!
 * Initializes the manager and setups login sources, call after login sources are set
 */
- (void)setupWithLaunchOptions:(NSDictionary *)options;

/*!
 * App delegate needs to call those methods to ensure OAuth calls are correctly passed
 */
- (void)handleDidBecomeActive;

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end