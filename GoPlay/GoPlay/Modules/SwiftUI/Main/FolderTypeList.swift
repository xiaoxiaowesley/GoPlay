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
          
            AppFolderView(title: NSLocalizedString("ApplicationFolder", comment: "The sandbox document folder")) {
                
            }
            DocumentFolderView(buttonAction: {
                FilesManager.shared.openFiles(viewController: hostingProvider.viewController!, action: {( urls: [URL]) -> Void in
                    
                })
            }, title: NSLocalizedString("FilesFolder", comment: "iOS system Files application"))
        }.onAppear(){
            
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
