//
//  AppFolderView.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

struct AppFolderView: View {
    let input: [String]
    let buttonAction: () -> Void // Expose the button's click action in the constructor
    
    @State private var showView = false
    @State private var rotationAngle: Double = 0
    
    
    var body: some View {
        Button(action: buttonAction) { // Use the exposed button action
            HStack(alignment: .top) {
                Image(systemName: "externaldrive.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                Text("应用文件夹")
                Spacer()
                Image(systemName: "arrow.clockwise")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: rotationAngle))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .leading)
        .padding(.vertical, 2)
        
        
        // foreach input to generate multi row
        ForEach(input, id: \.self) { item in
            Text(item).frame(height:30, alignment: .center)
        }
        
        .onAppear {
//            isAnimating = true // Start the animation when the view appears
        }
    }
}
//
//struct AppFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppFolderView()
//    }
//}

