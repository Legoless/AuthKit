AuthKit
=======

[![Stories in Ready](https://badge.waffle.io/Legoless/AuthKit.png?label=ready&title=Ready)](https://waffle.io/Legoless/AuthKit)
[![Build Status](http://img.shields.io/travis/legoless/AuthKit/master.svg?style=flat)](https://travis-ci.org/legoless/AuthKit)
[![Pod Version](http://img.shields.io/cocoapods/v/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod License](http://img.shields.io/cocoapods/l/AuthKit.svg?style=flat)](http://opensource.org/licenses/MIT)

AuthKit is to authentication as to what [**ARAnalytics**](https://github.com/orta/ARAnalytics) is to all analytics providers. AuthKit allows logging in into multiple online services and provides configured AFNetworking clients which you can use to access the corresponding REST API directly.

Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a Cocoa Pod, due to dependency conflicts. AuthKit fills this gap of providing `AFHTTPNetworkOperationManager` and `AFHTTPSessionManager`  classes configured to be used with any API, including **GitHub**, **Crashlytics** and more.

# Features

- Easily login to the next services:
  - [Crashlytics](http://www.crashlytics.com)
  - [Facebook](https://www.facebook.com)
  - [GitHub](https://github.com)
  - [Google+](https://plus.google.com)
  - [Travis CI](http://travis-ci.com)
  - ...
- Request logined user details for each service.
- Dynamic and customizable user interface for logging in into each service.
- Completely extensible clients and UI customizations.
- **A single, simple API to work with every service.**

# Contributing

Another service can easily be added by creating `AKClient` subclass and implementing the abstract methods in superclass. See either `AKGitHubClient` or `AKCrashlyticsClient` for example. Login layouts can be implemented subclassing the `AKAuthViewController` class.

# TODO

- Generic `UIViewController` supporting logging in
- Storing login data as Key-Value
- Full Keychain support using SSKeychain
- Add more social services
  - Amazon
  - App.net
  - Blogger
  - Disqus
  - Foursquare
  - Instagram
  - LinkedIn
  - LiveJournal
  - Mail.ru
  - Odnoklassniki
  - OpenID
  - Origin
  - PayPal
  - Reddit
  - Skyrock.com
  - StackExchange
  - Steam
  - Twitch.tv
  - Vimeo
  - VKontakte
  - Windows Live
  - WordPress.com
  - Yahoo
  - ...
- ReactiveCocoa support
- Keychain integration

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

**AuthKit** is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
