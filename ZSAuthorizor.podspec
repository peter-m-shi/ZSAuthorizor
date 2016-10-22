Pod::Spec.new do |s|

    s.name         = "ZSAuthorizor"
    s.version      = "0.0.1"
    s.summary      = "A iOS Kit For Authorization"

    s.description  = <<-DESC
        You can us ZSAuthorizor to manage your app Authorization. 
    DESC

    s.homepage     = "https://github.com/peter-m-shi/ZSAuthorizor"

    s.license      = "MIT"

    s.author       = { "peter.shi" => "peter.m.shi@outlook.com" }

    s.source       = { :git => "https://github.com/peter-m-shi/ZSAuthorizor.git", :tag => "0.0.1"}

    s.source_files  = 'ZSAuthorizor/**/*.{h,m}'

    s.requires_arc = true

    s.ios.deployment_target = '7.0'

    s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end

