//
//  TileView.swift
//  Puzzle
//
//  Created by Mark Meretzky on 11/15/14.
//  Copyright (c) 2014 Mark Meretzky. All rights reserved.
//

import UIKit

class TileView: UIImageView {
	let margin: CGFloat = 0.5;	//0.5 pairs of pixels = 1 pixel
	var row: Int = 0;	//current row and column numbers of this TileView
	var col: Int = 0;

	init(row: Int, col: Int) {
		let filename: String = "\(row + 1)\(col + 1).png";
		let image: UIImage? = UIImage(named: filename);
		if image == nil {
			println("could not open \(filename)");
		}
		super.init(image: image!);
		userInteractionEnabled = true;	//defaults to false in class UIImageView
		moveToRow(row, col: col);
	}

	//Never called.
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func moveToRow(row: Int, col: Int) {
		self.row = row;	//self.row is the property, row is the parameter
		self.col = col;

		center = CGPointMake(
			CGFloat(col) * (margin + bounds.size.width),
			CGFloat(row) * (margin + bounds.size.height));
	}

	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
		// Drawing code
	}
	*/

}
