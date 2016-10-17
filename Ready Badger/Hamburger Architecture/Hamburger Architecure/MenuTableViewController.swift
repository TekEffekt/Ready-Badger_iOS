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
import AVFoundation

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var hamburgerMenu: HamburgerMenu?
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: Sections
    private func numberForSection(forLink link: MenuLinks) -> Int {
        switch link {
            case .SettingsSection:
                return 1
            case .PreparedSection:
                return 4
            case .RespondSection:
                return 4
            case .MonitorSection:
                return 2
            case .ShelterSection:
                return 2
            case .AboutSection:
                return 1
            default:
                return 0
            }
    }
    
    // MARK: Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(numberForSection(forLink: MenuLinks.allSections[section])
        return numberForSection(forLink: MenuLinks.allSections[section])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuLinks.allSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Link") as? MenuLinkCell
            else {
                return  UITableViewCell()
        }
                
        let menuLinkName = MenuLinks.allValues[indexPath.section][indexPath.row].rawValue
        cell.name.text = menuLinkName
        cell.icon.image = UIImage(named: menuLinkName)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MenuLinks.allSections[section].rawValue
    }
    
    // MARK: Table Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenCell = tableView.cellForRow(at: indexPath as IndexPath) as! MenuLinkCell
        let linkName = chosenCell.name!.text!
        
        if (chosenCell.name.text == "Emergency Tone") {
            if (chosenCell.icon.image == UIImage(named: "Emergency Tone")) {
                chosenCell.icon.image = UIImage(named: "Emergency Tone On")
                
                let alertSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sos_sound", ofType: "mp3")!)
                
                var error:NSError?
                try! audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
                
                audioPlayer.numberOfLoops = -1
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }
            else {
                chosenCell.icon.image = UIImage(named: "Emergency Tone")
                audioPlayer.stop()
            }
        }
        else {
            hamburgerMenu!.openLink(linkName: linkName)
        }
    }
    
    
}
