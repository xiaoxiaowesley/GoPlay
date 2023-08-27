//
//  MainView.swift
//  GoPlay
//
//  Created by 肖湘 on 2023/8/27.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import Foundation

import Foundation
import Foundation
import SwiftUI
@objc
class MainViewInterface: NSObject {
 
    @objc func makeShipDetailsUI(_ name: String) -> UIViewController{
        let details = MainView()
        return UIHostingController(rootView: details)
    }
}

