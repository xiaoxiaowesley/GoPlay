//
//  DocumentFolderView.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct CardFolder: View {
    @EnvironmentObject var hostingProvider: ViewControllerProvider
    var body: some View {
        Group {
            FolderView()
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(BlurView(style: .regular))
                .cornerRadius(10)
                .padding(.vertical, 6)
                .padding(.horizontal).onTapGesture {
                    FilesManager.shared.openFiles(viewController: hostingProvider.viewController!, action: {( urls: [URL]) -> Void in
                        
                    })
                }
            
        }
    }
}

struct CardFolder_Previews: PreviewProvider {
    static var previews: some View {
        CardFolder()
    }
}

struct FolderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Image(systemName: "doc")
                        .foregroundColor(Color.white)
                }
                VStack(alignment: .center) {
                    Spacer()
                    Text(NSLocalizedString("ApplicationFolder", comment: "The sandbox document folder"))
                        .foregroundColor(Color.textColor)
                    Spacer()
                }.padding(.leading)
                Spacer()
                VStack {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.white)
                }
            }
        }
        
    }
}
