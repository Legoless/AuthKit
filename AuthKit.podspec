Pod::Spec.new do |s|
  s.name     = 'AuthKit'
  s.version  = '0.1.0'
  s.license  = 'MIT'
  s.summary  = 'All in one solution for web service authentication.'
  s.homepage = 'https://github.com/legoless/AuthKit.git'
  s.authors  = { 'Dal Rupnik' => 'legoless@gmail.com' }
  s.source   = { :git => 'https://github.com/legoless/AuthKit.git', :tag => "0.1.0" }
  s.platform = :ios, '7.0'
  s.requires_arc = true

  s.ios.deployment_target = '7.0'

  s.public_header_files = 'AuthKit/*.h'
  s.source_files = 'AuthKit/AuthKit.h'

  s.subspec 'Core' do |ss|
    ss.source_files = 'AuthKit/Core/*.{h,m}'
    
    ss.dependency 'AFNetworking', '~> 2.0'
  end

  s.subspec 'GitHub' do |ss|
    ss.source_files = 'AuthKit/GitHub/*.{h,m}'
    
    ss.dependency 'AuthKit/Core'

    ss.dependency 'JSONModel'
  end

end
