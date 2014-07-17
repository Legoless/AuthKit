//
//  AKGitHubUser.h
//  Pods
//
//  Created by Dal Rupnik on 10/07/14.
//
//

#import "JSONModel.h"

@protocol AKGitHubUser <NSObject>

@end

@interface AKGitHubUser : JSONModel

@property (nonatomic, strong) NSString* login;
@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString* avatar_url;
@property (nonatomic, strong) NSString* gravatar_id;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* html_url;
@property (nonatomic, strong) NSString* followers_url;
@property (nonatomic, strong) NSString* following_url;
@property (nonatomic, strong) NSString* gists_url;
@property (nonatomic, strong) NSString* starred_url;
@property (nonatomic, strong) NSString* subscriptions_url;
@property (nonatomic, strong) NSString* organizations_url;
@property (nonatomic, strong) NSString* repos_url;
@property (nonatomic, strong) NSString* events_url;
@property (nonatomic, strong) NSString* received_events_url;
@property (nonatomic, strong) NSString* type;
@property (nonatomic) BOOL site_admin;
@property (nonatomic, strong) NSString<Optional>* name;
@property (nonatomic, strong) NSString<Optional>* company;
@property (nonatomic, strong) NSString<Optional>* blog;
@property (nonatomic, strong) NSString<Optional>* location;
@property (nonatomic, strong) NSString<Optional>* email;
@property (nonatomic) BOOL hireable;
@property (nonatomic, strong) NSString<Optional>* bio;
@property (nonatomic) NSInteger public_repos;
@property (nonatomic) NSInteger public_gists;
@property (nonatomic) NSInteger followers;
@property (nonatomic) NSInteger following;
@property (nonatomic, strong) NSDate<Optional>* created_at;
@property (nonatomic, strong) NSDate<Optional>* updated_at;

@end
