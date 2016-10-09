/*
 * Copyright 2016 UW-Parkside AppFactory
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import UIKit
import LGSideMenuController
import JTHamburgerButton

class HamburgerMenu: LGSideMenuController {

    // MARK: Properties
    private var menuLinkTable: MenuTableViewController?
    internal var navController: UINavigationController?
    
    internal var hamButton: JTHamburgerButton?
    private var menuBarButton: UIBarButtonItem?
    
    var firstLoad = true
    
    // MARK: Initialization
    override func viewDidLoad() {
        setLeftViewEnabledWithWidth(250, presentationStyle: LGSideMenuPresentationStyle.slideAbove, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOptions(rawValue: 0))
        setupMenuNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if firstLoad {
            setupNavigationController()
            setupHamburgerButton()
            loadFirstMenuItem()
            setupMenuTable()
            setMenuFrame()
            
            firstLoad = false
        }
    }
    
    private func setupHamburgerButton() {
        hamButton = JTHamburgerButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        hamButton!.addTarget(self, action: #selector(HamburgerMenu.tappedMenu(sender:)), for: UIControlEvents.touchUpInside)
        
        menuBarButton = UIBarButtonItem(customView: hamButton!)
    }

    private func setupHamburgerButton(forController controller: UIViewController) {
        controller.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    private func setupMenuNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(HamburgerMenu.userOpenedMenu), name: NSNotification.Name(rawValue: kLGSideMenuControllerWillShowLeftViewNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HamburgerMenu.userReturnedFromMenu), name: NSNotification.Name(rawValue: kLGSideMenuControllerWillDismissLeftViewNotification), object: nil)
    }
    
    private func setupNavigationController() {
        navController = (storyboard!.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController)
        self.rootViewController = navController
    }
    
    private func loadFirstMenuItem() {
        let firstItem = navController!.viewControllers.first! as! MenuItem
        firstItem.menu = self
        
        let firstController = firstItem as! UIViewController
        setupHamburgerButton(forController: firstController)
    }
    
    private func setupMenuTable() {
        menuLinkTable = (storyboard!.instantiateViewController(withIdentifier: "Table") as! MenuTableViewController)
        menuLinkTable!.hamburgerMenu = self
        leftView().addSubview(menuLinkTable!.view)
    }
    
    private func setMenuFrame() {
        menuLinkTable!.view.frame = CGRect(x: 0, y: 64, width: 250, height: view.frame.height - 64)
    }
    
    // MARK: Changed Link
    func openLink(linkName name:String) {
        hideLeftView(animated: true, completionHandler: nil)
        guard let newItem = storyboard!.instantiateViewController(withIdentifier: name) as? MenuItem else { return }
        
        newItem.menu = self
        
        let newVc = newItem as! UIViewController
        
        if (name != "Emergency Tone") {
            navController!.viewControllers.removeFirst()
        }
        
        navController!.viewControllers.append(newVc)
        
        setupHamburgerButton(forController: newVc)
    }
    
    func tappedMenu(sender: JTHamburgerButton) {
        showLeftView(animated: true, completionHandler: nil)
    }
    
    // MARK: Update hamburger button
    func userReturnedFromMenu() {
        hamButton!.setCurrentModeWithAnimation(JTHamburgerButtonMode.hamburger)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
    }
    
    func userOpenedMenu() {
        hamButton!.setCurrentModeWithAnimation(JTHamburgerButtonMode.arrow)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.fade)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

