
Pod::Spec.new do |s|

  s.name         = "CrediteaseFinanceVC"
  s.version      = "0.0.1"
  s.summary      = "CrediteaseFinanceVC is used for finance h5"

  s.description  = <<-DESC
                    CrediteaseFinanceVC is used for finance h5 in big data center for babysleep and xuequ. I just test for pods
                   DESC

  s.homepage     = "https://github.com/csjlengxiang"
  s.license      = "MIT"


  s.author       = { "Chen Sijie" => "sijiechen3@creditease.cn" }
 
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/csjlengxiang/CrediteaseFinanceVCDemo.git", :tag => "#{s.version}" }

  s.source_files = "CrediteaseFinanceVCDemo/CrediteaseFinanceVC/**/*.{h,m}"

  s.dependency "Masonry"
  s.dependency "CrediteaseAnimation"

end
