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
            isAnimating.toggle() // Toggle the animation state when the button is clicked
        }) { // Use the exposed button action
            HStack(alignment: .top) {
                Image(systemName: "externaldrive.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                Text(title)
                Spacer()
                Image(systemName: "arrow.clockwise")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            rotationAngle = 360
                        }
                    }
                    .rotationEffect(Angle(degrees: isAnimating ? rotationAngle : 0)) // Apply rotation effect based on the animation state
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
        .padding(.vertical, 2)
        .onAppear {
            print("onAppear")
            
            isLoading = true
            DispatchQueue.global(qos: .background).async {
                self.input = fetchVideoFiles()
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
            
        }
        ForEach(input, id: \.self) { item in
            Text(item.filename)
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
//
//struct AppFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppFolderView()
//    }
//}

