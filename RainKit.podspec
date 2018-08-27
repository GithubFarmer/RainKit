#
# Be sure to run `pod lib lint RainKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RainKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RainKit.'
  s.homepage         = 'https://github.com/GithubFarmer/RainKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '喻永权' => 'rainy.yu@wwwarehouse.com' }
  s.source           = { :git => 'git@github.com:GithubFarmer/RainKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RainKit/Classes/**/*.{h,m}'
    s.dependency  "Masonry"
    s.dependency  "SDWebImage"
    s.dependency  "YYModel"
    s.dependency  "Aspects"
    s.dependency  "IQKeyboardManager"
    s.dependency  "YYModel"
    s.dependency  "WHKit"
end
