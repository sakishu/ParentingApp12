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
        guard let url = URL(string: "https://peraichi.com/landing_pages/view/privacypolicy528190") else { return }
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
    }
    
        
    
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        
        
        
        
    }
    

    

}
