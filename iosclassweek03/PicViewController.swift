//
//  PicViewController.swift
//  iosclassweek03
//
//  Created by YEN JUILEE on 2017/6/20.
//  Copyright © 2017年 YEN JUILEE. All rights reserved.
//

import UIKit

class PicViewController: UIViewController {
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var addList: UIBarButtonItem!
    
    var picName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addList.target = self
        addList.action = #selector(addToList)
        
        let parent = self.tabBarController as! TabBarController
        parent.navigationItem.rightBarButtonItem = addList
        picName = parent.picName
        pic.image = UIImage(named : picName)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addToList(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("quickPicList.txt")
        print("write")
        var s = ""
        do{
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\n"){
                s += line + "\n"
                if line == picName{
                    return
                }
            }
        }catch{
            return
        }
        s += picName + "\n"
        
        do{
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
        }catch{}
    }

}
