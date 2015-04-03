//
//  AKGitHubLogin.h
//  Pods
//
//  Created by Dal Rupnik on 01/07/14.
//
//

#import "AKGitHubApp.h"

#import "JSONModel.h"

@interface AKGitHubLogin : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSArray<Optional>* scopes;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString<Optional>* note;
@property (nonatomic, strong) NSString<Optional>* note_url;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic, strong) NSDate* updated_at;

@property (nonatomic, strong) AKGitHubApp* app;

@end
