
Pod::Spec.new do |s|
  s.name             = "Calendar"
  s.version          = "0.2.0"
  s.summary          = "Calendar is a collection view based calendar used in the app Leap Second"
  s.description      = <<-DESC
  Calendar is a collection view based calendar used in the app Leap Second
  * Allows scrolling up to navigate back
  * Paginated result calendar result
  * Customizeable date cells
                       DESC

  s.homepage         = "https://github.com/jonandersen/Calendar"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jon Andersen" => "jon@andersen.re" }
  s.source           = { :git => "https://github.com/jonandersen/Calendar.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Andersen_Jon'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Calendar' => ['Pod/Assets/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
