//
//  ViewController.swift
//  RJUtils_Swift
//
//  Created by Ronniejia on 04/01/2020.
//  Copyright (c) 2020 Ronniejia. All rights reserved.
//

import UIKit
import RJUtils_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        v.backgroundColor = RJHexColor(hex: "#FF1100")
        view.addSubview(v)
        v.x(100)
        
        
        self.RJ_showProgressHUD()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.RJ_hideProgressHUD()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

