//
//  ViewController.swift
//  LeanCloudDemo
//
//  Created by Howie Zeng on 16/6/3.
//  Copyright © 2016年 zenghao0708. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let key = "TestObject"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func queryButtonTapped(sender: UIButton) {
        queryObject()
    }
    
    @IBAction func deleteAllButtonTapped(sender: UIButton) {
        deleteAllObject()
    }
    
}

extension ViewController {
    
    func createObject() {
        let post = AVObject(className: key)
        post.setObject("Hello World", forKey: "words")
        post.saveInBackgroundWithBlock { (succeed, error) in
            if succeed {
                print("succeeded, object id: \(post.objectId)")

            }
        }
    }
    
    func updateObject() {
        let query = AVQuery(className: key)
        query.getObjectInBackgroundWithId("57514538530fd30068efa5e1") { (object, error) in
            print("object: \(object)")
        }
    }
    
    func deleteAllObject() {
        let query = AVQuery(className: key)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                let testObjects = objects as! [AVObject]
                testObjects.forEach({ $0["words"] = "test"})
                AVObject.saveAllInBackground(testObjects, block: { (succeed, error) in
                    if succeed {
                        print("deleteAllObject succeed")
                    }
                })
            }
        }
    }
    
    func queryObject() {
        let query = AVQuery(className: key)
        query.getObjectInBackgroundWithId("57514538530fd30068efa5e1") { (object, error) in
            print("object: \(object)")
        }
    }

    
}
