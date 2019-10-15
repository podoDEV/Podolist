platform :ios, '11.0'
workspace 'Podolist'

inhibit_all_warnings!
use_frameworks!

def common
    # Networking
    pod 'Alamofire'
    pod 'Moya'

    # Logging
    pod 'CocoaLumberjack/Swift'

    # Etc
    pod 'SwiftLint'
    pod 'Scope'
    pod 'KeychainAccess', '~> 3.1.2'
end

def ui
    pod 'SnapKit'
    pod 'PodoCalendar', '~> 0.2.7'
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

target 'PodolistTests' do
    common
    spec
end

target 'PodolistUITests' do
    common
    spec
end
