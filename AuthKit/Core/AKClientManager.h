//
// Created by Dal Rupnik on 23/03/15.
//

@import UIKit;

#import "AKLoginSource.h"
#import "AKClient.h"

/*!
 * Manager of clients per application, supports multiple login sources
 */
@interface AKClientManager : NSObject

@property (nonatomic, readonly) NSArray* loginSources;

/*!
 * Returns registered login source by name
 */
- (AKClient<AKLoginSource> *)loginSourceWithName:(NSString *)name;

/*!
 * Returns login source by class
 */
- (AKClient *)loginSourceWithClass:(Class)class;

/*!
 * Singleton access to shared manager
 */
+ (instancetype)sharedManager;

/*!
 * Adds login source
 */
- (void)addLoginSource:(AKClient<AKLoginSource> *)source;

/*!
 * Initializes the manager and setups login sources, call after login sources are set
 */
- (void)setup;

#pragma mark - UIApplicationDelegate methods

/*!
 * App delegate needs to call those methods to ensure OAuth calls are correctly passed
 */

- (void)handleDidBecomeActive;

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end