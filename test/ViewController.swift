//
//  ViewController.swift
//  test
//
//  Created by Merouane Bellaha on 12/06/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var brownView: UIView!

    // Create an optional UISwipeGestureRecognizer
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the swipeGestureRecognizer, and add action (a method: presentActivityController) to be trigger when swipe is used
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(presentActivityController))
        // Add a second action (a method: gridViewTranslate) to be trigger when swipe is used
        swipeGestureRecognizer?.addTarget(self, action: #selector(gridViewTranslate))

        // Unwrap optional value of swipeGestureRecognizer
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }

        // Add the gesture to the object
        brownView.addGestureRecognizer(swipeGestureRecognizer)

        // NotificationCenter is gonna be notified everytime the device orientation change ( UIDevice.orientationDidChangeNotification )
        // And is gonna trigger the selected method ( handleSwipeDirection ) everytime the NotificationCenter is notified
        NotificationCenter.default.addObserver(self, selector: #selector(handleSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc
    func presentActivityController() {
        // Initialize an UIActivityViewController with the item you want to share (brownView.image)
        let activityController = UIActivityViewController(activityItems: [brownView.image], applicationActivities: nil)
        // Display the activityController
        present(activityController, animated: true)

        // Define code you want to execute as soon as the activityController is dismissed
        // completionWithItemsHandler property accepts a closure with 4 parameters (That we're not gonna use here, so instead of naming them just "name" them "_")
        activityController.completionWithItemsHandler = { _, _, _, _ in
            // "Animate" an UIView transformation
            UIView.animate(withDuration: 0.5, animations: {
                // Bring back the brownView to his initial coordinates
                self.brownView.transform = .identity
            })
        }

    }

    @objc
    func gridViewTranslate() {
        if UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown {
            // "Animate" an UIView transformation
            UIView.animate(withDuration: 0.5, animations: {
                // Transform the brownView coordinates
                self.brownView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.brownView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            })
        }
    }

    // Modify the swipeGestureRecognizer direction
    @objc
    func handleSwipeDirection() {
        if UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown {
            swipeGestureRecognizer?.direction = .up
        } else {
            swipeGestureRecognizer?.direction = .left
        }
    }
}
