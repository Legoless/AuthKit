//
//  AKGitHubApp.h
//  Pods
//
//  Created by Dal Rupnik on 01/07/14.
//
//

#import "JSONModel.h"

@interface AKGitHubApp : JSONModel

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* client_id;

@end
