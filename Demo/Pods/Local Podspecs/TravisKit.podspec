Pod::Spec.new do |s|
  s.name         = "TravisKit"
  s.version      = "1.0.0"
  s.summary      = "Travis CI iOS/OS X API Wrapper"
  s.homepage     = "https://github.com/legoless/TravisKit"
  s.license      = 'MIT'
  s.authors      = { "Dal Rupnik" => "legoless@gmail.com" }
  s.source       = { :git => "https://github.com/legoless/TravisKit.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '7.0'
  s.frameworks   = 'Foundation', 'UIKit', 'CoreGraphics'
  s.requires_arc = true
  
  s.subspec 'Log' do |ss|
    ss.source_files = "TravisKit/Log/*.{h,m}"
    ss.dependencies = ['libPusher']
  end
  
  s.subspec 'Model' do |ss|
    ss.source_files = "TravisKit/Model/*.{h,m}"
    ss.dependency 'AFNetworking', '~> 2.0'
    ss.dependency 'JSONModel'
  end

end