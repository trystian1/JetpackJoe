//
//  GameViewController.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 15/01/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenter.shared.authenticateLocalPlayer(presentingVC: self)
        let menuNode = GameMenu(size: view.frame.size);
        if let view = self.view as! SKView? {
            view.presentScene(menuNode)
//            view.ignoresSiblingOrder = true
//            view.showsPhysics = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
    }

    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in

            if (viewController != nil) {
                self.present(viewController!, animated: true, completion: nil)
            }
            else {
                print((GKLocalPlayer.local.isAuthenticated))
            }
        }
    }
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
