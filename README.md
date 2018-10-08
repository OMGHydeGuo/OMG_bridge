# OMG_bridge

[![CI Status](https://img.shields.io/travis/Hyde Guo/OMG_bridge.svg?style=flat)](https://travis-ci.org/Hyde Guo/OMG_bridge)
[![Version](https://img.shields.io/cocoapods/v/OMG_bridge.svg?style=flat)](https://cocoapods.org/pods/OMG_bridge)
[![License](https://img.shields.io/cocoapods/l/OMG_bridge.svg?style=flat)](https://cocoapods.org/pods/OMG_bridge)
[![Platform](https://img.shields.io/cocoapods/p/OMG_bridge.svg?style=flat)](https://cocoapods.org/pods/OMG_bridge)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0

## Installation

OMG_bridge is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OMG_bridge'
```

First , to set user tenant key
```ruby
instance.tenantKey = "XXXXX"
```

Start bridge detect , you just need to instance ListeningController . And call

```ruby
startRecord()
```
Get data , will return data from BridgeDelegate .
```ruby
func onGetBridgeData(data:BridgeBody?)
```

If you need to  start detect by shaking the phone , just extends BaseBridgeViewController


## Author

Hyde Guo, hydeguo@onwardsmg.com

## License

OMG_bridge is available under the MIT license. See the LICENSE file for more info.
