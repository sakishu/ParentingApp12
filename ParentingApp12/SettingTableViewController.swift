//
//  SettingTableViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/02/05.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class SettingTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          switch section {
          case 0: // 「設定」のセクション
            return 1
          case 1: // 「その他」のセクション
            return 3
          default:
            return 0
          }
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0, indexPath.row == 0 {
            
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let SecondController = storyboard.instantiateViewController(withIdentifier: "EntryVC")
            present(SecondController, animated: true, completion: nil)
            
        }else if indexPath.section == 1, indexPath.row == 0 {
            self.sendMail()
        }else if indexPath.section == 1,indexPath.row == 1{
        guard let url = URL(string: "https://github.com/sakishu/ParentingApp12/commit/1cefab04a77bc22c4c2a25f55266e5a15ec51bbb#diff-76e54fc4af9757bcee8e9b0a55ea1514") else { return }
        let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
            
        }else if indexPath.section == 1,indexPath.row == 2 {
            
        guard let url = URL(string: "https://peraichi.com/landing_pages/view/riyoukiyaku528190") else { return }
        let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
            }
        }
    //新規メールを開く
        func sendMail() {
            //メール送信が可能なら
            if MFMailComposeViewController.canSendMail() {
                //MFMailComposeVCのインスタンス
                let mail = MFMailComposeViewController()
                //MFMailComposeのデリゲート
                mail.mailComposeDelegate = self
                //送り先
                mail.setToRecipients(["tomonori528190@gmail.com"])
                //Cc
                mail.setCcRecipients([""])
                //Bcc
                mail.setBccRecipients([""])
                //件名
                mail.setSubject("件名")
                //メッセージ本文
                mail.setMessageBody("", isHTML: false)
                //メールを表示
                self.present(mail, animated: true, completion: nil)
            //メール送信が不可能なら
            } else {
                //アラートで通知
                let alert = UIAlertController(title: "No Mail Accounts", message: "Please set up mail accounts", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //エラー処理
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if error != nil {
                //送信失敗
                print(error as Any)
            } else {
                switch result {
                case .cancelled: break
                    //キャンセル
                case .saved: break
                    //下書き保存
                case .sent: break
                    //送信
                default:
                    break
                }
                controller.dismiss(animated: true, completion: nil)
            }
        }
    }
    

    

