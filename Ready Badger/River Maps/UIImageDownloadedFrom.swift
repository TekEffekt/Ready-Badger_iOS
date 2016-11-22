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

import Foundation
import UIKit

extension UIImageView {
    
    // get an image from a url string and set the UIImage's .image property to said image
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else {return}
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            guard let mimeType = response?.mimeType else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            guard httpURLResponse.statusCode == 200 else { return }
            guard mimeType.hasPrefix("image") else { return }
            
            OperationQueue.main.addOperation {
                self.image = image
            }
        }).resume()
    }
}
