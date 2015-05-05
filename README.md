[![AuthKit](https://raw.githubusercontent.com/Legoless/AuthKit/master/Resource/logo.png)](https://github.com/legoless/AuthKit)

[![Stories in Ready](https://badge.waffle.io/Legoless/AuthKit.png?label=ready&title=Ready)](https://waffle.io/Legoless/AuthKit)
[![Build Status](https://travis-ci.org/Legoless/AuthKit.svg)](https://travis-ci.org/legoless/AuthKit)
[![Pod Version](http://img.shields.io/cocoapods/v/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod License](http://img.shields.io/cocoapods/l/AuthKit.svg?style=flat)](http://opensource.org/licenses/MIT)

AuthKit provides a system to login into multiple online (social) services. Use a custom-built view controller to display login interface for any AuthKit supported service. To add your 

*AuthKit is to authentication as to what [**ARAnalytics**](https://github.com/orta/ARAnalytics) is to all analytics providers.  It wraps multiple SDK's and provides configured AFNetworking clients which you can use to communicate with the service REST API directly, such as Facebook's Graph API. Or you can use the underlying library directly for specific functionality.*

# Features

- Easily login to the next services:
  - Password Based Authentication 
    - [Crashlytics](http://www.crashlytics.com)
    - [GitHub](https://github.com)
  - OAuth Based Authentication
    - [Facebook](https://www.facebook.com)
    - [Google+](https://plus.google.com)
    - [LinkedIn](https://linkedin.com)
    - [Twitter](https://twitter.com)
    - [Windows Live](https://www.live.com)
  - ...
- Request logined user details for each service.
- Dynamic and customizable user interface for logging in into each service.
- Completely extensible clients and UI.
- **A single, simple API to work with every service.**

# Install

The easiest way to install **AuthKit** is with **CocoaPods**.

```ruby
pod 'AuthKit'
```

As alternative install method, you can manually drag & drop files from the repository into your Xcode project.

If you wish to install only specific services of AuthKit (*for example, only install Facebook and Twitter login clients*), use separate subspecs.

```
pod 'AuthKit/Facebook'
pod 'AuthKit/Twitter'
```

The example above will only install `AKClient` implementations of **Facebook** and **Twitter**. If you are also going to use AuthKit interface extensions, such as login screen, also include:

```
pod 'AuthKit/Interface'
```

# Getting Started

When AuthKit is installed, you need to import it's client implementations:

```
#import <AuthKit/AKFacebook.h>
#import <AuthKit/AKTwitter.h>
```

### Password Based Authentication

If you are be using only password based authentication services, all you need to do is a new instance of it's appropriate client (does not matter where). See the example below:

```
AKGitHubClient *github = [[AKGitHubClient alloc] initWithClientID:@"<CLIENT_ID>" clientSecret:@"<CLIENT_SECRET>" scopes:@[ AKGitHubScopeUser, AKGitHubScopeRepo ] note:@"Test"];
```

When you want the user to login, just call the login function:

```
[github loginWithUsername:username password:password success:^(id user) { ... } failure:^(id object, NSError *error) { ... }];
```

### OAuth Based Authentication

With OAuth Based Services certain calls must be handled manually:
- Application Launch Options (`NSDictionary` provided by `application:didFinishLaunchingWithOptions`) need to be redirected to specific login service,
- Application to active state must be redirected to login service (`applicationDidBecomeActive:` method),
- Application opened by URL must be redirected to login service (`application:openURL:sourceApplication:annotation` method).

While every login service implementation supports this, the recommeded way is to use `AKClientManager` shared instance. See the example below:

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AKFacebookClient *facebook = [[AKFacebookClient alloc] initWithPermissions:@[ AKFacebookPermissionPublicProfile, AKFacebookPermissionEmail ]];

    // Register Facebook client with client manager
    [[AKClientManager sharedManager] addLoginSource:facebook];
    
    [[AKClientManager sharedManager] setupWithLaunchOptions:launchOptions];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AKClientManager sharedManager] handleDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[AKClientManager sharedManager] handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end

```

### User interface

AuthKit provides a login screen out of the box and is implemented by `AKAuthViewController` class. The class needs at least one login source (instance of an object that implements `AKLoginSource` protocol) to be used. View controller dynamically adapts to login source and supports both `AKOAuthLoginSource` and `AKPasswordLoginSource` clients. Logging into multiple services is supported.

### Adding custom login source

Another service can easily be added by creating `AKClient` subclass and implementing the abstract methods in superclass. See either `AKGitHubClient` or `AKCrashlyticsClient` for example. Login layouts can be implemented subclassing the `AKAuthViewController` class.

# Architecture

## Protocols



# History

AuthKit was originally implemented due to encountering a project that needed to make GitHub API calls, but used AFNetworking 2.x throughout entire project. Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a Cocoa Pod, due to dependency conflicts. 

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**AuthKit** is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
