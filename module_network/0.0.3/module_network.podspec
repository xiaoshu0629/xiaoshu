#
# Be sure to run `pod lib lint module_network.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'module_network'
  s.version          = '0.0.3'
  s.summary          = 'network request for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xiaoshu/module_network'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaoshu' => 'xiaoshu@xiaoyezi.com' }
  s.source           = { :git => 'ssh://codereview.xiaoyezi.com:29418/moduleNetwork-iOS', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.dependency 'AFNetworking', '~> 3.2.1'

  s.subspec 'Manager' do |ss|

  ss.source_files = 'module_network/Manager/**/*.{h,m}'

  ss.public_header_files = "module_network/Manager/**/*.{h}"

  end
  s.subspec 'NetReachability' do |ss|

  ss.source_files = 'module_network/NetReachability/**/*.{h,m}'

  ss.public_header_files = "module_network/NetReachability/**/*.{h}"

  end
  
  # s.resource_bundles = {
  #   'module_network' => ['module_network/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
