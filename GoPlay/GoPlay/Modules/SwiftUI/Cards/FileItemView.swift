////
//  FileItemView.swift
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
//  Created by xiaoxiang's m1 mbp on 2023/9/14.
//  Copyright © 2023 dKingbin. All rights reserved.

import SwiftUI

struct FileItemView: View {
    var dataObject: DataObject
    var onTap: ((DataObject) -> Void)? // Add callback function with dataObject parameter
    var body: some View {
        HStack{
            Image(systemName: "play.square")
                .foregroundColor(Color.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading){
                Text(dataObject.filename)
                    .foregroundColor(Color.textColor)
                    .lineLimit(1)
                    .font(.system(size: 16)) // Increase font size
                    .foregroundColor(.gray)
                    .padding(.top, 2)
                    .padding(.bottom, 0) // Decrease bottom padding
                    .background(Color.clear)
                
                Text(dataObject.timeString)
                    .foregroundColor(Color.textColor)
                    .lineLimit(1)
                    .font(.system(size: 10))
                    .padding(.bottom, 2)
                    .background(Color.clear)
            }
        }.onTapGesture {
            onTap?(dataObject) // Call the callback function with dataObject when tapped
        }
    }
}

struct FileItemView_Previews: PreviewProvider {
    static var previews: some View {
        FileItemView(dataObject:DataObject(filename: "big_buck_bunny.mp4", fullpath: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", time: 1694691386))
    }
}
