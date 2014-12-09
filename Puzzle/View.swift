//
//  View.swift
//  Puzzle
//
//  Created by Mark Meretzky on 11/15/14.
//  Copyright (c) 2014 Mark Meretzky. All rights reserved.
//

import UIKit

class View: UIView {
	var emptyRow: Int = 1;	//Lower right position is initially empty.
	var emptyCol: Int = 1;
    var nmoves: Int = 0;
    var rank: String = "Rank:";
    let label: UILabel = UILabel();
    let textview: UITextView = UITextView();

    override init(frame: CGRect) {
        super.init(frame: frame);
        
		self.backgroundColor = UIColor.greenColor();

		for var row = -1; row <= 1; ++row {
			for var col = -1; col <= 1; ++col {

				//Skip the missing tile.
				if row == emptyRow && col == emptyCol {
					continue;
				}

				let tileView: TileView = TileView(row: row, col: col);
				addSubview(tileView);
			}
		}

		//Let the center of this View be the origin (0, 0).
		bounds.origin = CGPointMake(
			-bounds.size.width / 2,
			-bounds.size.height / 2);
        for var i = 0; i < 100; ++i {
            //Pick a random number in the range 0 to 7 inclusive.
            //Then convert the random number from UInt32 to plain old Int.
            let r: Int = Int(arc4random_uniform(8));
            
            //Pick a random TileView, i.e., one of the last 8 items in the
            //subviews property of this View.
            let tileView: TileView = subviews[subviews.count - 1 - r] as TileView;
            
            tryToMoveTileViewStart(tileView);
        }


        var s: String = "\(nmoves) \(rank)";
        let font: UIFont! = UIFont(name: "Didot-Italic", size: 35);
        let attributes: [NSObject: AnyObject] = [NSFontAttributeName: font];
        let size: CGSize = s.sizeWithAttributes(attributes);
        
        //Put upper left corner of label in upper left corner of application frame.
        //Make label just big enough to hold the string.
        let screen: UIScreen = UIScreen.mainScreen();
        let applicationFrame: CGRect = screen.applicationFrame;
        
        let f: CGRect = CGRectMake(
            applicationFrame.origin.x - 150,
            applicationFrame.origin.y + 150,
            300,
            250);
        

        
        
        var title: String = "Slider Puzzle";
        let titlefont: UIFont? = UIFont(name: "Didot-Italic", size: 50);
        let titleattributes: [NSObject: AnyObject] = [NSFontAttributeName: font];
        let titlesize: CGSize = title.sizeWithAttributes(attributes);
        
        //Put upper left corner of label in upper left corner of application frame.
        //Make label just big enough to hold the string.
        
        
        let titlef: CGRect = CGRectMake(
            applicationFrame.origin.x - 150,
            applicationFrame.origin.y - 300,
            300,
            100);
        
        label = UILabel(frame: titlef);
        label.backgroundColor = UIColor.clearColor();
        label.font = titlefont;
        label.text = title;
        addSubview(label);
        
        textview = UITextView(frame: f);
        textview.backgroundColor = UIColor.clearColor();
        textview.font = font;
        textview.text = s;
        addSubview(textview);
        
        
        
        
        
	}
   
   
	//Never called.
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		let touch: UITouch = touches.anyObject() as UITouch;
		let point: CGPoint = touch.locationInView(self);

		//Which of the 8 subviews (TileViews) was touched?
		let view: UIView? = hitTest(point, withEvent: event);
		if view == nil || view == self {
			return;	//No TileView was touched.
		}

		let tileView: TileView = view as TileView;
		tryToMoveTileView(tileView);

	}

	//Move the given TileView if it is not landlocked.

	func tryToMoveTileView(tileView: TileView) {
		//Can the TileView move into the empty location?
		//Or is the TileView landlocked?
		let dRow: Int = abs(tileView.row - emptyRow);
		let dCol: Int = abs(tileView.col - emptyCol);
		if dRow + dCol != 1 {
			return;	//Landlocked.
		}

		//Remember where the TileView is.
		let saveRow: Int = tileView.row;
		let saveCol: Int = tileView.col;

		//Move the TileView into the empty location.
		UIView.animateWithDuration(0.5,
			delay: 0,
			options: UIViewAnimationOptions.CurveEaseInOut,
			animations: {tileView.moveToRow(self.emptyRow, col: self.emptyCol);},
			completion: nil);

		//The location where the TileView was is now the empty location.
		emptyRow = saveRow;
		emptyCol = saveCol;

        
        nmoves++
        println("\(nmoves)");
        if nmoves > 20 {
            rank = "You Got This, Just A Little More";
            println("\(rank)");
        }
        else if nmoves > 10 {
            rank = "That's It";
            println("\(rank)");
        }
        else if nmoves > 2 {
            rank = "Keep Going ...";
            println("\(rank)");
        };
        
        textview.text = "# Moves: " + String(nmoves) + " \(rank)";
        

        }
        
	
    
    func tryToMoveTileViewStart(tileView: TileView) {
        //Can the TileView move into the empty location?
        //Or is the TileView landlocked?
        let dRow: Int = abs(tileView.row - emptyRow);
        let dCol: Int = abs(tileView.col - emptyCol);
        if dRow + dCol != 1 {
            return;	//Landlocked.
        }
        
        //Remember where the TileView is.
        let saveRow: Int = tileView.row;
        let saveCol: Int = tileView.col;
        
        //Move the TileView into the empty location.
        UIView.animateWithDuration(3.0,
            delay: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {tileView.moveToRow(self.emptyRow, col: self.emptyCol);},
            completion: nil);
        
        //The location where the TileView was is now the empty location.
        emptyRow = saveRow;
        emptyCol = saveCol;
    }

	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
		// Drawing code
	}
	*/

}
