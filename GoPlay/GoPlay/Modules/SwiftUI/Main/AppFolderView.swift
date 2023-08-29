//
//  AppFolderView.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct DataObject  {
    let filename: String
    let fullpath: String
}

extension DataObject: Hashable {
    static func == (lhs: DataObject, rhs: DataObject) -> Bool {
        return lhs.fullpath == rhs.fullpath && lhs.filename == rhs.filename
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(fullpath)
        hasher.combine(filename)
    }
}


struct AppFolderView: View {
    let title:String
    let buttonAction: () -> Void // Expose the button's click action in the constructor
    
    @State private var showView = false
    @State private var rotationAngle: Double = 0
    @State private var isAnimating = true // Add a state variable to control the animation
    @State private var isLoading = false
    @State private var input: [DataObject]
    
    init(title: String, buttonAction: @escaping () -> Void) {
        self.title = title
        self.buttonAction = buttonAction
        self.input = [] // Initialize the input array
    }
    
    var body: some View {
        Button(action: {
            buttonAction();
        })
        { // Use the exposed button action
            HStack(alignment: .top) {
                Image(systemName: "externaldrive.fill")
                    .renderingMode(.template)
                    .foregroundColor(FUColors.todo)
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(FUColors.todo)
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
        .padding(.vertical, 2)
        .onAppear {
            print("onAppear")
            isLoading = true
            DispatchQueue.global(qos: .background).async {
                self.input = fetchVideoFiles()
                
                if self.input.count == 0 {
                    self.input.append(DataObject(filename: "big_buck_bunny.mp4", fullpath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"))
                    self.input.append(DataObject(filename: "clips.vorwaerts-gmbh.mp4", fullpath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"))
                }
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        }
        HStack {
            Image(systemName: "ellipsis")
                .foregroundColor(FUColors.todo)
            Text("最近导入")
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                // 刷新
            }) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(FUColors.todo)
            }
        }
        VStack {
            ForEach(input, id: \.self) { item in
                Button(action: {
                    let player = PlayViewController()
                    player.url = item.fullpath
                    let nav = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
                    nav?.pushViewController(player, animated: true)
                }) {
                    Text(item.filename).foregroundColor(.white)
                }
            }
        }
    }
    
    func fetchVideoFiles() -> [DataObject] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let docPath = documentsURL
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: docPath, includingPropertiesForKeys: nil)
            let filePaths:[String]  = fileURLs.filter { $0.pathExtension == "mp4" }.map { $0.path }
            let dataObjects = filePaths.map { DataObject(filename:URL(fileURLWithPath: $0).lastPathComponent, fullpath:  $0) }
            return dataObjects
        } catch {
            print("Error while enumerating files \(docPath.path): \(error.localizedDescription)")
        }
        return []
    }
}

struct AppFolderView_Previews: PreviewProvider {
    static var previews: some View {
        AppFolderView(title: NSLocalizedString("ApplicationFolder", comment: "The sandbox document folder")) {
            
        }
    }
}

