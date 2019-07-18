# Spider
[![Build Status](https://travis-ci.org/hoangtaiki/Spider.svg)](https://travis-ci.org/hoangtaiki/Spider)
[![codecov](https://codecov.io/gh/hoangtaiki/Spider/branch/master/graph/badge.svg)](https://codecov.io/gh/hoangtaiki/Spider)
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

`Spider` is a library designed to stub your network requests very easily.

## Requirements

- Xcode 10.2 or later
- iOS 10.0 or later
- Swift 5

## Getting Started

### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your `Podfile`:

```
platform :ios, '10.0'
use_frameworks!
pod 'Spider'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Spider into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "hoangtaiki/Spider" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `Spider.framework` into your Xcode project.


## Usage

To stub a request, first you need to create a `StubRequest` and `StubResponse`. Then you need add this stub with Spider and tell it to intercept network requests by calling the `start()` method.

### Create a stub request with absolute url
```
let url = "https://www.apple.com"
let matcher = url.asStringMatcher()
let responseBody = "{\"value\":\"test\"}".data(using: .utf8)
let response = StubResponse(body: responseBody)
let request = StubRequest(method: .GET, matcher: matcher, response: response)
Spider.default.addStubRequest(request)
Spider.default.start()
```

This request will only accept url has `absoluteString` is `https://www.apple.com`

### Create a stub request with relative url
```
let url = "https://www.apple.com"
let regex = try! NSRegularExpression(pattern: appleURLString, options: [])
let matcher = RegexMatcher(regex: regex)

let responseBody = "{\"value\":\"test\"}".data(using: .utf8)
let response = StubResponse(body: responseBody)
let request = StubRequest(method: .GET, matcher: matcher, response: response)
Spider.default.addStubRequest(request)
Spider.default.start()
```

This request will accept any request start with `https://www.apple.com`. Example: `https://www.apple.com/home` and `https://www.apple.com/users/1`


## Contributing

We’re glad you’re interested in Spider, and we’d love to see where you take it. If you have suggestions or bug reports, feel free to send pull request or create new issue.

Thanks, and please *do* take it for a joyride!