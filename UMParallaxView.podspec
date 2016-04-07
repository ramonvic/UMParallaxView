Pod::Spec.new do |s|

  s.name         = "UMParallaxView"
  s.version      = "0.1.1"
  s.summary      = "A Swift View Parallax header for UITableView, UIScrollView"

  s.homepage     = "https://github.com/ramonvic/UMParallaxView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors       = { "Ramon Vicente" => "ramonvicentesilva@hotmail.com" }

  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/ramonvic/UMParallaxView.git", :tag => "0.1.1" }

  s.source_files  = "UMParallaxView/**/*.swift"

  s.requires_arc = true

end
