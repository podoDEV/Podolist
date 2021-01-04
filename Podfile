platform :ios, '13.0'
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
  pod 'KakaoSDKCommon'
  pod 'KakaoSDKAuth'
  pod 'KakaoSDKUser'
end

def ui
  pod 'SnapKit'
  pod 'PodoCalendar', '~> 0.2.7'
end

target 'Podolist' do
  project 'Podolist/Podolist'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  common
  networking
  logging
  sdk
  ui
end

target 'PodolistWidget' do
  project 'Podolist/Podolist'
  common
  logging
  ui
end

target 'Features' do
  project 'Features/Features'
  common
  logging
  sdk
  ui
end

target 'Services' do
  project 'Features/Features'
  common
  networking
  logging
end

target 'Core' do
  project 'Core/Core'
  common
  networking
  logging
end
