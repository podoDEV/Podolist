# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
workspace 'Podolist'

inhibit_all_warnings!
use_frameworks!

def common
    # Rx
    pod 'RxSwift', '~> 4.1.2'
    pod 'RxCocoa', '~> 4.1.2'

    # Networking
    pod 'Alamofire', '~> 4.7.2'
    pod 'SwiftyJSON', '~> 4.1.0'

    # Logging
    pod 'CocoaLumberjack/Swift'

    # Etc
    pod 'Then'
    pod 'SwiftLint'
    pod 'KeychainAccess', '~> 3.1.1'
end

def ui
    pod 'PodoCalendar', '~> 0.2.5'
end

def analytics
    pod 'GoogleAnalytics'
end

def spec
    pod 'Quick', '~> 1.3.0'
    pod 'Nimble', '~> 7.1.1'
end

target 'Podolist' do
    common
    ui
    analytics
end

target 'PodolistTest' do
    common
    ui
    analytics
end

target 'PodolistTests' do
    common
    spec
end

target 'PodolistUITests' do
    common
    spec
end
