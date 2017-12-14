//
//  ViewController.swift
//  libsqliteInSwift
//
//  Created by 苏俊杰 on 2017/12/14.
//  Copyright © 2017年 苏俊杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LibsqliteHander.runNormalSql("create table if not exists Student(name text PRIMARY KEY,age integer DEFAULT 15)");
        
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰1\",19)")
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰2\",18)")
        LibsqliteHander.runNormalSql("insert into Student(name,age) values(\"杰3\",17)")
        
        LibsqliteHander.selectSql();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

