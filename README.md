[![AuthKit](https://raw.githubusercontent.com/Legoless/AuthKit/master/Resource/logo.png)](https://github.com/legoless/AuthKit)

[![Stories in Ready](https://badge.waffle.io/Legoless/AuthKit.png?label=ready&title=Ready)](https://waffle.io/Legoless/AuthKit)
[![Build Status](https://travis-ci.org/Legoless/AuthKit.svg)](https://travis-ci.org/legoless/AuthKit)
[![Pod Version](http://img.shields.io/cocoapods/v/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/AuthKit.svg?style=flat)](http://cocoadocs.org/docsets/AuthKit/)
[![Pod License](http://img.shields.io/cocoapods/l/AuthKit.svg?style=flat)](http://opensource.org/licenses/MIT)

AuthKit provides a system to login into multiple online (social) services. Use a custom-built view controller to display login interface for any AuthKit supported service. It's main purpose is solving the implementation of login system in every application separately.

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

# The Story

*AuthKit was originally developed because a fairly simple project needed to make GitHub API calls, but used AFNetworking 2.x throughout entire project. Since AFNetworking 1.x and 2.x are incompatible with different APIs, many existing wrapper libraries (such as [OctoKit](https://github.com/octokit/octokit.objc)) cannot be used if 2.x version is installed as a Cocoa Pod, due to dependency conflicts.

From there the library was extended to support multiple login services and tools to aid with authentication on iOS.*

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

# Documentation

The entire **AuthKit** documentation is available on [Wiki](https://github.com/Legoless/AuthKit/wiki) and on [CocoaDocs](http://cocoadocs.org/docsets/AuthKit/).

- Read [Getting Started](https://github.com/Legoless/AuthKit/wiki/Getting-Started).
- Browse [Architecture](https://github.com/Legoless/AuthKit/wiki/Architecture).
- Go through [Frequently Asked Questions](https://github.com/Legoless/AuthKit/wiki/FAQ).

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**AuthKit** is available under the MIT license. See [LICENSE](https://github.com/Legoless/AuthKit/blob/master/LICENSE) file for more information.
