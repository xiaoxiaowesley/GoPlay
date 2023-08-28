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
            AppFolderView(title:"应用文件夹",input: ["String.txt","hello.mp4","hello.mp4","hello.mp4"],buttonAction: {
                
            })
            DocumentFolderView(buttonAction: {
                FilesManager.shared.openFiles(viewController: hostingProvider.viewController!, action: {([URL]) -> Void in
                    //print urls
                })
            }, title: "文件")
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
