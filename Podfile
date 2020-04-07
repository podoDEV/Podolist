platform :ios, '11.0'
workspace 'Podolist'

inhibit_all_warnings!
use_frameworks!

def common
  pod 'SwiftLint'
  pod 'Scope', '~> 1.2.0'
  pod 'KeychainAccess', '~> 3.1.2'
end

def networking
  pod 'Alamofire'
  pod 'Moya'
end

def logging
  pod 'SwiftyBeaver'
  pod 'Umbrella'
  pod 'Umbrella/Firebase'
end

def sdk
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
end

def ui_common
  pod 'SnapKit'
end

def ui_app
  ui_common
  pod 'PodoCalendar', '~> 0.2.7'
end

target 'Podolist' do
  common
  networking
  logging
  sdk
  ui_app
end

target 'PodolistWidget' do
  common
  ui_common
  logging
end

target 'Core' do
  common
  networking
  logging
end
