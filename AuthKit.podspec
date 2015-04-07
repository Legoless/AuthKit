Pod::Spec.new do |s|
  s.name     = 'AuthKit'
  s.version  = '0.7.0'
  s.license  = 'MIT'
  s.summary  = 'All in one solution for web service authentication.'
  s.homepage = 'https://github.com/legoless/AuthKit.git'
  s.authors  = { 'Dal Rupnik' => 'legoless@gmail.com' }
  s.source   = { :git => 'https://github.com/legoless/AuthKit.git', :tag => s.version }
  s.platform = :ios, '7.0'
  s.requires_arc = true
 
  s.ios.deployment_target = '7.0'

  s.public_header_files = 'AuthKit/*.h'
  s.source_files = 'AuthKit/AuthKit.h'

  s.subspec 'Core' do |ss|
    ss.source_files = 'AuthKit/Core/*.{h,m}'
    
    ss.dependency 'AFNetworking', '~> 2.x'
    ss.dependency 'JSONModel'
  end

  s.subspec 'Persistence' do |ss|
    ss.source_files = 'AuthKit/Persistence/*.{h,m}'

    ss.dependency 'AuthKit/Core'
    ss.dependency 'SSKeychain'
    ss.dependency 'Haystack'
  end

  s.subspec 'OAuth' do |ss|
  	ss.source_files = 'AuthKit/OAuth/*.{h,m}'

  	ss.dependency 'AuthKit/Core'
  end
  
  s.subspec 'Interface' do |ss|
    ss.source_files = 'AuthKit/Interface/*.{h,m}'
    
    ss.dependency 'AuthKit/Core'
    ss.dependency 'AKPickerView'
    ss.dependency 'Haystack'
    ss.dependency 'PureLayout'
  end

  s.subspec 'GitHub' do |ss|
    ss.source_files = 'Service/GitHub/*.{h,m}'
    
    ss.dependency 'AuthKit/Core'
  end
  
  s.subspec 'Crashlytics' do |ss|
    ss.source_files = 'Service/Crashlytics/*.{h,m}'
    
    ss.dependency 'AuthKit/Core'
  end

  s.subspec 'Facebook' do |ss|
    ss.source_files = 'Service/Facebook/*.{h,m}'

    ss.dependency 'Facebook-iOS-SDK/LoginKit'
    ss.dependency 'AuthKit/Core'
    ss.dependency 'AuthKit/OAuth'
  end

  s.subspec 'Google' do |ss|
    ss.source_files = 'Service/Google/*.{h,m}'

    ss.dependency 'googleplus-ios-sdk'
    ss.dependency 'AuthKit/Core'
    ss.dependency 'AuthKit/OAuth'
  end
end
