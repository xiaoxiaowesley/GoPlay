//
//  DocumentFolderView.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct DocumentFolderView: View {
    let buttonAction: () -> Void
    let title:String
    
    var body: some View {
        Button(action: {
            self.buttonAction()
        }) {
            HStack(alignment: .top) {
                Image(systemName: "folder.fill")
                    .renderingMode(.template)
                    .foregroundColor(.todo)
                Text(title)
                    .foregroundColor(.white)

            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
        .padding(.vertical, 2)
    }
}
struct DocumentFolderView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentFolderView(buttonAction: {
        }, title: "文件")
    }
}
