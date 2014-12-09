//
//  ViewController.swift
//  Puzzle
//
//  Created by Mark Meretzky on 11/15/14.
//  Copyright (c) 2014 Mark Meretzky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func loadView() {
		let screen: UIScreen = UIScreen.mainScreen();
		view = View(frame: screen.bounds);
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

