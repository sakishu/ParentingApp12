//
//  PrivacyPolicyViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/21.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit
import SafariServices

class PrivacyPolicyViewController: UIViewController {

    @IBAction func TermsButton(_ sender: Any) {
        guard let url = URL(string: "https://peraichi.com/landing_pages/view/riyoukiyaku528190") else { return }
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
        
        }

    @IBAction func PrivacyButton(_ sender: Any) {
        guard let url = URL(string: "https://github.com/sakishu/ParentingApp12/commit/1cefab04a77bc22c4c2a25f55266e5a15ec51bbb#diff-76e54fc4af9757bcee8e9b0a55ea1514") else { return }
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
    }
    
        
    
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        
        
        
        
    }
    

    

}
