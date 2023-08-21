//
//  ListViewInterface.swift
//  GoPlay
//
//  Created by 肖湘 on 2023/8/8.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import Foundation
import Foundation
import SwiftUI
@objc
class ListViewInterface: NSObject {
 
    @objc func makeShipDetailsUI(_ name: String) -> UIViewController{
        let details = ListView()
        return UIHostingController(rootView: details)
    }
}

