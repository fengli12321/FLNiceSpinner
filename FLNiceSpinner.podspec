#
# Be sure to run `pod lib lint FLNiceSpinner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FLNiceSpinner'
  s.version          = '0.0.1'
  s.summary          = 'iOS Spinner like Android'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      iOS下拉框控件
                       DESC

  s.homepage         = 'https://github.com/fengli12321/FLNiceSpinner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'foxPower' => '954751186@qq.com' }
  s.source           = { :git => 'https://github.com/fengli12321/FLNiceSpinner.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  s.source_files = 'FLNiceSpinner/Classes/**/*'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
  s.requires_arc = true
  # s.resource_bundles = {
  #   'FLNiceSpinner' => ['FLNiceSpinner/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
