//
//  ListView.swift
//  GoPlay
//
//  Created by 肖湘 on 2023/8/8.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import SwiftUI

import Foundation

func fetchVideoFiles() -> [String] {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let docPath = documentsURL
    
    do {
        let fileURLs = try fileManager.contentsOfDirectory(at: docPath, includingPropertiesForKeys: nil)
        let filePaths:[String]  = fileURLs.filter { $0.pathExtension == "mp4" }.map { $0.path }

        var screenshots: [String] = []
        for url in filePaths {
            let captureFrame = FFmpegUtil.captureFrame(url)
            if captureFrame != nil {
                screenshots.append(captureFrame)
            }
            
//            if let screenshot = FFmpegUtil.captureFrame(url) {
//                screenshots.append(screenshot)
//            }
        }
        return screenshots

    } catch {
        print("Error while enumerating files \(docPath.path): \(error.localizedDescription)")
    }
    
    return []
}


struct ListViewItem: View {
    let imagePath: String
    var body: some View {
        let image = UIImage(named: imagePath)
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 120, height: 90) // 4:3 aspect ratio
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 4)
                        .shadow(color: .gray, radius: 4, x: 2, y: 2)
                )
            
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

struct ListView: View {
    @State private var videoFiles: [String] = []
    @State private var isLoading: Bool = true

    init(videoFiles: [String] = []) {
        _videoFiles = State(initialValue: videoFiles)
    }
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView() // Loading animation
            } else {
                if #available(iOS 14.0, *) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                        ForEach(videoFiles, id: \.self) { videoFile in
                            ListViewItem(imagePath: videoFile)
                        }
                    }
                    .padding()
                } else {
                    // Fallback on earlier versions
                }
            }
        }            
        .navigationBarTitle("Video Files", displayMode: .inline)
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                videoFiles = fetchVideoFiles()
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        }
    }

    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(videoFiles: ["video1.mp4", "video2.mp4", "video3.mp4"])
    }
}
