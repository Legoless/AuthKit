![AuthKit](https://raw.githubusercontent.com/Legoless/AuthKit/master/Resource/logo.png)

[![Stories in Ready](https://badge.waffle.io/Legoless/AuthKit.png?label=ready&title=Ready)](https://waffle.io/Legoless/AuthKit)
[![Build Status](https://travis-ci.org/Legoless/AuthKit.svg)](https://travis-ci.org/legoless/AuthKit)
[![Pod Version](http://img.shields.io/cocoapods/v/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod License](http://img.shields.io/cocoapods/l/AuthKit.svg?style=flat)](http://opensource.org/licenses/MIT)

AuthKit provides a system to login into multiple online (social) services. Use a custom-built view controller to display login interface for any AuthKit supported service.

AuthKit is to authentication as to what [**ARAnalytics**](https://github.com/orta/ARAnalytics) is to all analytics providers.  It wraps multiple SDK's and provides configured AFNetworking clients which you can use to communicate with the service REST API directly, such as Facebook's Graph API. Or you can use the underlying library directly for specific functionality.

# Features

- Easily login to the next services:
  - [Crashlytics](http://www.crashlytics.com)
  - [Facebook](https://www.facebook.com)
  - [GitHub](https://github.com)
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

If you wish to install only selected parts of AuthKit (*for example, only install Facebook and Twitter login clients*), use separate subspecs.

```
pod 'AuthKit/Facebook'
pod 'AuthKit/Twitter'
```

The example above will only install `AKClient` implementations of **Facebook** and **Twitter**.

# Getting Started

AuthKit is implemented as a single login API that wraps multiple services.

```
#import <AuthKit/AKFacebook.h>
#import <AuthKit/AKTwitter.h>
```

All **AuthKit** clients derive from `AKClient` class, which wraps login implementation to only a few of methods. For a full OAuth implementation, `AKLoginManager` class needs to be called from your app delegate, so URL redirect calls are correctly redirected to the underlying SDK.

# Client Implementation

Another service can easily be added by creating `AKClient` subclass and implementing the abstract methods in superclass. See either `AKGitHubClient` or `AKCrashlyticsClient` for example. Login layouts can be implemented subclassing the `AKAuthViewController` class.

# History

AuthKit was originally implemented due to encountering a project that needed to make GitHub API calls, but used AFNetworking 2.x throughout entire project. Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a Cocoa Pod, due to dependency conflicts. 

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

**AuthKit** is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
