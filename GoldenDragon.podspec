Pod::Spec.new do |s|

 
  s.name                    = "GoldenDragon"
  s.version                 = "1.0.0"
  s.summary                 = "A networking framework"
  s.description             = "GoldenDragon is a set of files to perform basic networking operations"
  s.homepage                = "https://github.com/harshvishu/GoldenDragon"
  s.license                 = 'MIT'
  s.author                  = { "harsh" => "vishwakarma.harsh1993@gmail.com" }
  s.source                  = { :git => "https://github.com/harshvishu/GoldenDragon.git", :tag => s.version }
  s.source_files            = "GoldenDragon"
  s.swift_version        = '5.0'
  s.ios.deployment_target   = '10.0'
  s.documentation_url       = "https://github.com/harshvishu/GoldenDragon"
  s.ios.deployment_target   = '10.0'
end

