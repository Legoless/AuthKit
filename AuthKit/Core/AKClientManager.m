//
// Created by Dal Rupnik on 23/03/15.
//

#import <AuthKit/AKLoginSource.h>
#import "AKClientManager.h"

@interface AKClientManager ()

@property (nonatomic, assign, getter=isSetuped) BOOL setuped;
@property (nonatomic, strong) NSMutableOrderedSet *sources;

@end

@implementation AKClientManager

+ (instancetype)sharedManager
{
    static AKClientManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });

    return shared;
}

- (NSArray *)loginSources
{
    return [self.sources array];
}

- (NSMutableOrderedSet *)sources
{
    if (!_sources)
    {
        _sources = [NSMutableOrderedSet orderedSet];
    }

    return _sources;
}

/*!
 * Returns registered login source by name
 */
- (AKClient<AKLoginSource> *)loginSourceWithName:(NSString *)name
{
    for (id object in self.sources)
    {
        if ([object respondsToSelector:@selector(sourceName)] && [[object sourceName] isEqualToString:name])
        {
            return object;
        }
    }
    
    return nil;
}

/*!
 * Returns login source by class
 */
- (AKClient *)loginSourceWithClass:(Class)class
{
    for (id object in self.sources)
    {
        if ([object isKindOfClass:class])
        {
            return object;
        }
    }
    
    return nil;
}

- (void)addLoginSource:(id <AKLoginSource>)source
{
    [self.sources addObject:source];
}

- (void)setup
{
    //
    // Setup should not be called more than once
    //
    if (self.isSetuped)
    {
        return;
    }

    self.setuped = YES;

    //
    // Notifications
    //

    for (id source in self.sources)
    {
        if ([source respondsToSelector:@selector(setup)])
        {
            [source setup];
        }
    }
}

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL handleURL = NO;

    //
    // If one of the sources will handle this URL, we will return YES
    //

    for (id source in self.sources)
    {

        if ([source respondsToSelector:@selector(handleURL:sourceApplication:annotation:)])
        {
            BOOL response = [source handleURL:url sourceApplication:sourceApplication annotation:annotation];

            if (response)
            {
                handleURL = YES;
            }
        }
    }

    return handleURL;
}

- (void)handleDidBecomeActive
{
    for (id source in self.sources)
    {
        if ([source respondsToSelector:@selector(handleDidBecomeActive)])
        {
            [source handleDidBecomeActive];
        }
    }
}

@end