//
//  FolderTypeList.swift
//  GoPlay
//
//  Created by 肖湘 on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct FolderTypeList: View {
    var body: some View {
        List {
            ForEach(["应用目录 -最近有个文件更新", "文件-查看", "远端-上次创建"], id: \.self) { item in
                Button(action: {
                    print("Folder item clicked: \(item)")
                }) {
                    HStack(alignment: .top) {
                        Image(systemName: "folder")
                        Text(item)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
                .padding(.vertical, 2)
            }
        }
    }
}

struct FolderTypeList_Previews: PreviewProvider {
    static var previews: some View {
        FolderTypeList()
    }
}

