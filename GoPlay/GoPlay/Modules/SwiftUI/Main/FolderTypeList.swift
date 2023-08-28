//
//  FolderTypeList.swift
//  GoPlay
//
//  Created by 肖湘 on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct FolderTypeList: View {
    @EnvironmentObject var hostingProvider: ViewControllerProvider

    
    var body: some View {
        List {
            AppFolderView()
            DocumentFolderView()
        } .onAppear {
            updateNaviBarColor(title: Color.white, background: FUColors.turquoise)
        }
    }
   
    
    
    func updateNaviBarColor(title:Color,background:Color){
        
        let controller = hostingProvider.viewController
        
        if let navi = controller?.navigationController {
                            
            let backgourndColor = UIColor(background)
            let titleColor = UIColor(title)
            
            
            navi.navigationBar.tintColor = titleColor
            navi.navigationBar.backgroundColor = backgourndColor
            if #available(iOS 13.0, *) {
                if let keyWindow = UIApplication.shared.keyWindow {
                    let statusBar = UIView(frame: keyWindow.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                    statusBar.backgroundColor = backgourndColor
                    keyWindow.addSubview(statusBar)
                }
            } else {
                if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
                    statusBar.backgroundColor = backgourndColor
                }
            }
            navi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        }
    }
}
//
//struct FolderTypeList_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderTypeList()
//    }
//}
//
