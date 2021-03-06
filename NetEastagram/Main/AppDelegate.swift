//
//  AppDelegate.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2016/12/30.
//  Copyright © 2016年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let tabVC = MainTabBarViewController()
            tabVC.viewControllers = [UINavigationController.init(rootViewController: HomeViewController()), UINavigationController.init(rootViewController: SearchViewController()), UINavigationController.init(rootViewController: ShootViewController()), UINavigationController.init(rootViewController: UserViewController())]
            window.rootViewController = tabVC
            window.makeKeyAndVisible()
        }
        // custom bar
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor(netHex: 0x607d8b)
        navigationBarAppearace.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0), NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.backIndicatorImage = UIImage(named: "back-icon")
        navigationBarAppearace.backIndicatorTransitionMaskImage = UIImage(named: "back-icon")
        
        UIApplication.shared.statusBarStyle = .lightContent
        setStatusBarBackgroundColor(color: UIColor(netHex: 0x3b515c))
        
        //for test
        if UserDefaults.standard.string(forKey: Constants.USER_INFO_KEY) == nil {
            let user = UserModel.init(name: "arron", userID: 19920212)
            UserDefaults.standard.set(user.toJSONString(), forKey: Constants.USER_INFO_KEY)
        }
        let userString = UserDefaults.standard.string(forKey: Constants.USER_INFO_KEY)
        let model = UserModel.deserialize(from: userString)
        SharedPreferences.shared().name = model?.name
        SharedPreferences.shared().userID = model?.userID
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

