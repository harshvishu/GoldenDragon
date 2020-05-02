Pod::Spec.new do |s|

 
  s.name                    = "GoldenDragon"
  s.version                 = "1.0.0"
  s.summary                 = "A networking framework"
  s.description             = "GoldenDragon is a set of files to perform basic networking operations"
  s.homepage                = "https://github.com/harshvishu/GoldenDragon"
  s.author                  = { "harsh" => "vishwakarma.harsh1993@gmail.com" }
  s.source                  = { :git => "https://github.com/harshvishu/GoldenDragon.git", :tag => s.version.to_s }
  s.swift_version        = '5.0'
  s.ios.deployment_target   = '10.0'
  s.documentation_url       = "https://github.com/harshvishu/GoldenDragon"
  s.ios.deployment_target   = '10.0'
  s.license       = { :type => 'MIT',
  :text => %Q|Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n| +
		   %Q|The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n| +
		   %Q|THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE| }
  s.subspec 'Core' do |core|
	s.source_files            = "GoldenDragon/Core/*.swift"
  end

end

