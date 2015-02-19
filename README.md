AuthKit
=======

AuthKit is to authentication as to what [**ARAnalytics**](https://github.com/orta/ARAnalytics) is to all analytics providers. AuthKit allows logging in into multiple online services and provides configured AFNetworking clients which you can use to access the API directly.

Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a CocoaPod, due to dependency conflicts. AuthKit fills this gap of providing `AFHTTPNetworkOperationManager` classes configured to be used with any API, including **GitHub**, **Crashlytics** and more.

# Features

- Easily login to the next services:
  - [Crashlytics](http://www.crashlytics.com)
  - [GitHub](https://github.com)
  - [Travis CI](http://travis-ci.com)
  - ...
- Request logined user details for each service
- Dynamic and customizable user interface for logging in into each service
- Completely extensible clients and UI
- iOS 8 support

# Contributing

Another service can easily be added by creating `AKClient` subclass and implementing the abstract methods in superclass. See either `AKGitHubClient` or `AKCrashlyticsClient` for example. Login layouts can be implemented subclassing the `AKAuthViewController` class.

# TODO

- Generic `UIViewController` supporting logins
- Storing login data as Key-Value
- Keychain support
- Add more social services
  - Pinterest
  - Facebook
  - Twitter
  - App.net
  - Google+ (Gmail)
  - LinkedIn
  - Steam
  - Evernote
  - Origin
  - Instagram
  - ...
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

AuthKit is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
