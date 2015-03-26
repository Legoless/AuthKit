//
//  AKGitHubUser.m
//  Pods
//
//  Created by Dal Rupnik on 10/07/14.
//
//

#import "AKGitHubUser.h"

@implementation AKGitHubUser

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray* optional = @[ @"public_gists", @"hireable", @"followers", @"public_repos", @"following" ];

    return ([optional containsObject:propertyName]);
}

@end
