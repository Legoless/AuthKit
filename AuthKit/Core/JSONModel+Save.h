//
//  AKLocalModel.h
//  AuthKit
//
//  Created by Dal Rupnik on 29/07/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AKLocalModel : JSONModel

+ (NSString *)storeKey;

- (void)save;
- (void)delete;

+ (instancetype)loginedUser;

@end