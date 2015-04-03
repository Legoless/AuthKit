//
// Created by Dal Rupnik on 24/03/15.
//

#import "AKUser.h"

@interface AKUser (Storage)

+ (AKUser *)userForClient:(AKClient *)client;

+ (NSArray *)savedUsers;

@end