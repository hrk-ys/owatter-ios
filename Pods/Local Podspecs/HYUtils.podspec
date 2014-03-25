Pod::Spec.new do |s|
  s.name         = "HYUtils"
  s.version      = "0.0.7"
  s.summary      = "HYUtils."
  s.license      = 'MIT'
  s.author       = "hrk-ys" 
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source       = { :git => "git@github.com:hrk-ys/HYUtils.git", :tag => "0.0.7" }
  s.source_files  = 'HYUtils', 'HYUtils/**/*.{h,m}'
  s.exclude_files = 'HYUtilsDemo'
  s.dependency 'CocoaLumberjack'
end
