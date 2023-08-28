//
//  AppFolderView.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct AppFolderView: View {
    var body: some View {

        Button(action: {
            print("Folder item clicked")
        }) {
            HStack(alignment: .top) {
                Image(systemName: "doc.on.doc.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                Text("应用文件夹")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
        .padding(.vertical, 2)
        
    }
}
//
//struct AppFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppFolderView()
//    }
//}
