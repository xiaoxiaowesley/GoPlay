////
//  DataManager.swift
//  GoPlay
//
//                             _ooOoo_
//                            o8888888o
//                            88" . "88
//                            (| -_- |)
//                            O\  =  /O
//                         ____/`- -'\_____
//                       .'  \\|     |//  `.
//                      /  \\|||  :  |||//  \
//                     /  _||||| -:- |||||-  \
//                     |   | \\\  -  /// |   |
//                     | \_|  ''\- -/''  |   |
//                     \  .-\____`-` ____/-. /
//                  ____`. .'  /--.--\  `. . ____
//                ."" '<  `.__.\_<|>_/.__.'  >'"".
//               | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//               \  \ `-.   \_ __\ /__ _/   .-` /  /
//                `-._ __`-..__\__ __/__..-`__ _.-'
//                             `=--='
//          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                     佛祖保佑        永无BUG
//            佛曰:
//                   写字楼里写字间，写字间里程序员；
//                   程序人员写程序，又拿程序换酒钱。
//                   酒醒只在网上坐，酒醉还来网下眠；
//                   酒醉酒醒日复日，网上网下年复年。
//                   但愿老死电脑间，不愿鞠躬老板前；
//                   奔驰宝马贵者趣，公交自行程序员。
//                   别人笑我忒疯癫，我笑自己命太贱；
//                  
//  Created by 肖湘 on 2023/11/15.
//  Copyright © 2023 dKingbin. All rights reserved.

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {
        // Initialize DataManager
        videoFiles = []
    }

    
    /// 获取文件
    func getFiles(callback: @escaping ([DataObject]) -> Void){
        DispatchQueue.global(qos: .background).async {
            self.videoFiles = self.fetchVideoFiles()
            DispatchQueue.main.async {
                callback(self.videoFiles)
            }
        }
    }
    
    /// 同步搜视频文件
    private func fetchVideoFiles() -> [DataObject] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let docPath = documentsURL
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: docPath, includingPropertiesForKeys: nil)
            
            // TODO: 过滤所有的视频文件
            let filePaths:[String]  = fileURLs.filter { $0.pathExtension == "mp4" }.map { $0.path }
            let dataObjects = filePaths.map { DataObject(filename:URL(fileURLWithPath: $0).lastPathComponent, fullpath:  $0, time: 1694691386) }
            
            
            if dataObjects.isEmpty {
                // FOR TEST
                return [
                    DataObject(filename: "big_buck_bunny.mp4", fullpath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", time: 1694691386),
                    DataObject(filename: "clips.vorwaerts-gmbh.mp4", fullpath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", time: 1672506061)
                ]
            }
            
            return dataObjects
        } catch {
            print("Error while enumerating files \(docPath.path): \(error.localizedDescription)")
        }
        
        return []
    }
    
    private var videoFiles : [DataObject]
}
