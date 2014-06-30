//
//  TravisKit.h
//  TravisKit
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#ifndef _TRAVISKIT_
    #define _TRAVISKIT_

    #import "TKClient.h"

    #import "TKAccount.h"
    #import "TKAnnotation.h"
    #import "TKBranch.h"
    #import "TKBroadcast.h"
    #import "TKBuild.h"
    #import "TKCache.h"
    #import "TKCommit.h"
    #import "TKHook.h"
    #import "TKJob.h"
    #import "TKRepository.h"
    #import "TKRequest.h"
    #import "TKRequestPayload.h"
    #import "TKPermissions.h"
    #import "TKSettings.h"
    #import "TKUser.h"

#endif

@interface TravisKit : NSObject

+ (TKClient *)openSourceClient;
+ (TKClient *)privateClient;
+ (TKClient *)clientWithURL:(NSString *)url;

@end