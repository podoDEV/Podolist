# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
workspace 'Podolist'

inhibit_all_warnings!
use_frameworks!

def common_pods
  # Pods for Reactive
  pod 'RxSwift', '~> 4.1.2'
  pod 'RxCocoa', '~> 4.1.2'

  # Pods for Networking
  pod 'Alamofire', '~> 4.7.2'
  pod 'SwiftyJSON', '~> 4.1.0'

  # Pods for Code consistency
  pod 'SwiftLint'

  # Pods for Account Managing
  pod 'KeychainAccess', '~> 3.1.1'
end

def ui_pods
end

def spec_pods
  # Pods for testing
  pod 'Quick', '~> 1.3.0'
  pod 'Nimble', '~> 7.1.1'

  # Pods for testing
  pod 'RxNimble', '~> 4.1.0'
end

target 'Podolist' do
  common_pods
  ui_pods
end

target 'PodolistTests' do
  common_pods
  spec_pods
end

target 'PodolistUITests' do
  common_pods
  spec_pods
end
