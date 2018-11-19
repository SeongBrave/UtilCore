#
# Be sure to run `pod lib lint UtilCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UtilCore'
  s.version          = '0.0.4'
  s.summary          = '项目公用基础库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 项目公用基础库，单独模块.
                       DESC

  s.homepage         = 'https://github.com/seongbrave/UtilCore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'seongbrave' => 'seongbrave@sina.com' }
  s.source           = { :git => 'https://github.com/seongbrave/UtilCore.git', :tag => s.version.to_s }
  s.social_media_url = 'http://seongbrave.github.io/'
  s.ios.deployment_target = '8.0'
  s.source_files = 'UtilCore/**/*.{h,swift}'
  s.resource_bundles = {
      'UtilCore' => ['UtilCore/**/*.{xcassets,storyboard}']
  }
  s.frameworks = 'UIKit'
  s.dependency 'ModelProtocol', '~> 0.1.0'
  s.dependency 'EmptyDataView', '~> 0.1.0'
  s.dependency 'RxSwift', '~> 4.4.0'  #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
  s.dependency 'RxCocoa', '~> 4.4.0'
  s.dependency 'CryptoSwift', '~> 0.13.0'
  s.dependency 'SwiftyUserDefaults', '~> 4.0.0-alpha.1'
  #动画显示
  s.dependency 'NVActivityIndicatorView', '~> 4.4.0'
  #autolayout的封装
  s.dependency 'SnapKit', '~> 4.2.0'
  #toast提示框
  s.dependency 'Toast-Swift', '~> 4.0.0'
  s.dependency 'MJRefresh', '~> 3.1.15.7'
  s.dependency 'Kingfisher', '~> 4.10.1'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
  s.dependency 'URLNavigator', '~> 2.1.0'
  s.dependency 'WebViewJavascriptBridge', '~> 6.0.3'
end
