//
//  DisasterInfoPageController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/12/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DisasterInfoPageController: UIViewController, DefaultTheme {

    @IBOutlet weak var webView: UIWebView!
    var disasterType: DisasterInfoType!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        let htmlFile = Bundle.main.path(forResource: disasterType.rawValue, ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        webView.loadHTMLString(html!, baseURL: nil)
    }

}
