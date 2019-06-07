//
//  ViewController.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 06/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getGifs(for: "cats", page: 0) { results in
            results.forEach {
                print($0.url)
            }
        }
    }

}

