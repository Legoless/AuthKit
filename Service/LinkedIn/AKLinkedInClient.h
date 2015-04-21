//
// Created by Dal Rupnik on 23/03/15.
//

#import "AKClient.h"
#import "AKOAuthSource.h"
#import "AKLoginSource.h"

@interface AKLinkedInClient : AKClient <AKLoginSource, AKOAuthSource>

@end