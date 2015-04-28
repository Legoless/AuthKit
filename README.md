AuthKit
=======

[![Stories in Ready](https://badge.waffle.io/Legoless/AuthKit.png?label=ready&title=Ready)](https://waffle.io/Legoless/AuthKit)
[![Build Status](http://img.shields.io/travis/legoless/AuthKit/master.svg?style=flat)](https://travis-ci.org/legoless/AuthKit)
[![Pod Version](http://img.shields.io/cocoapods/v/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod License](http://img.shields.io/cocoapods/l/AuthKit.svg?style=flat)](http://opensource.org/licenses/MIT)

AuthKit is to authentication as to what [**ARAnalytics**](https://github.com/orta/ARAnalytics) is to all analytics providers. AuthKit allows logging in to multiple online services with really easy API. It wraps multiple SDK's and provides configured AFNetworking clients which you can use to communicate with the service REST API directly, such as Facebook's Graph API.

Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a Cocoa Pod, due to dependency conflicts. AuthKit fills this gap of providing `AFHTTPNetworkOperationManager` and `AFHTTPSessionManager`  classes configured to be used with any API, including **GitHub**, **Crashlytics** and more.

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
- Completely extensible clients and UI customizations.
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

# Usage

AuthKit is very easy to use, start by importing client implementations:

```
#import <AuthKit/AKFacebook.h>
#import <AuthKit/AKTwitter.h>
```

All **AuthKit** clients derive from `AKClient` class, which wraps login implementation to only a few of methods. For a full OAuth implementation, `AKLoginManager` class needs to be called to your app delegate, to redirect calls correctly to the correct underlying SDK.

# Contributing

Another service can easily be added by creating `AKClient` subclass and implementing the abstract methods in superclass. See either `AKGitHubClient` or `AKCrashlyticsClient` for example. Login layouts can be implemented subclassing the `AKAuthViewController` class.

# TODO

- Storing login data as Key-Value with Full Keychain support using SSKeychain
- Add more social services
  - Amazon
  - Blogger
  - Disqus
  - Instagram
  - LiveJournal
  - Mail.ru
  - Odnoklassniki
  - OpenID
  - Origin
  - Skyrock.com
  - Twitch.tv
  - Vimeo
  - VKontakte
  - WordPress.com
  - ...
- ReactiveCocoa support
- Swift Support

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

**AuthKit** is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
