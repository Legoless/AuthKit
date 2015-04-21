//
// Created by Dal Rupnik on 20/04/15.
//

#import "AKClient.h"
#import "AKOAuthSource.h"
#import "AKLoginSource.h"

@interface AKTwitterClient : AKClient <AKLoginSource, AKOAuthSource>

@end