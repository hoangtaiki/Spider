Pod::Spec.new do |s|
  s.name = 'Spider'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = '🕷 An elegant library for stubbing HTTP requests with ease in Swift'
  s.homepage = 'https://github.com/hoangtaiki/Spider'
  s.authors = { 'Hoangtaiki' => 'duchoang.vp@gmail.com' }
  s.source = { :git => 'https://github.com/hoangtaiki/Spider.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.platform = :ios, "10.0"

  s.source_files = 'Spider/Sources/**/*.swift'

  s.ios.frameworks = 'UIKit', 'Foundation'
end
