# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'Ready Badger' do
pod 'OneSignal'
pod 'JTHamburgerButton'
pod 'RealmSwift'
pod 'Validator'
pod 'MBProgressHUD', '~> 1.0.0'
pod 'AEXML'
pod 'SwiftyJSON'
pod 'LGSideMenuController'
pod 'Firebase/Core'
pod 'Firebase/Crash'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
