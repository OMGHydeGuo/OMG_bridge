#
# Be sure to run `pod lib lint OMG_bridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OMG_bridge'
  s.version          = '0.1.9'
  s.summary          = 'OMG bridge.'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/OMGHydeGuo/OMG_bridge'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hyde Guo' => 'hydeguo@onwardsmg.com' }
  s.source           = { :git => 'https://github.com/OMGHydeGuo/OMG_bridge.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '10.0'

  s.source_files = 'OMG_bridge/Classes/**/*'
  
   s.resource_bundles = {
       #    'OMG_bridge' => ['OMG_bridge/Assets/MP3/*']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Alamofire'
   s.dependency 'Alamofire', '~> 4.6'
end
