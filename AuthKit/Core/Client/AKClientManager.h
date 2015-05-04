//
// Created by Dal Rupnik on 23/03/15.
//

@import UIKit;

#import "AKLoginSource.h"
#import "AKClient.h"
#import "AKOAuthLoginSource.h"

/*!
 * Manager of clients per application, supports multiple login sources, but only one per type,
 * because underlying SDK's usually do not support more than a single logined user at a time.
 */
@interface AKClientManager : NSObject

/*!
 * Singleton access to shared manager
 */
+ (instancetype)sharedManager;

#pragma mark - Retrieve Login Sources

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

#pragma mark - Add Login Sources

//
// These methods should be called when application starts, so they are correctly setuped.
//

/*!
 *  Adds single login source
 *
 *  @param source login source
 */
- (void)addLoginSource:(id<AKLoginSource>)source;

/*!
 *  Adds multiple login sources
 *
 *  @param loginSources array of AKLoginSource instances
 */
- (void)addLoginSources:(NSArray *)loginSources;

#pragma mark - AKOAuthLoginSource

/*!
 *  Initializes the manager and setups login sources, call after login sources are set
 */
- (void)setupWithLaunchOptions:(NSDictionary *)options;

/*!
 *  App delegate needs to call those methods to ensure OAuth calls are correctly passed
 */
- (void)handleDidBecomeActive;

/*!
 *  Method should be called by Application Delegate, so token information is correctly
 *  sent to underlying login source.
 *
 *  @param url               url that was opened
 *  @param sourceApplication source application
 *  @param annotation        annotation
 *
 *  @return YES when one of the login sources will handle the URL call
 */
- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end