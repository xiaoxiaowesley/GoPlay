////
//  CardDocument.swift
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
//  Created by 肖湘 on 2023/9/8.
//  Copyright © 2023 dKingbin. All rights reserved.

import SwiftUI

struct CardDocument: View {
    var body: some View {
        Group {
            CardView()
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(BlurView(style: .regular))
                .cornerRadius(10)
                .padding(.vertical, 6)
                .padding(.horizontal)

        }
    }
}

struct CardDocument_Previews: PreviewProvider {
    static var previews: some View {
        CardDocument()
    }
}

struct CardView: View {
//    var p: ListData
//    let namespace: Namespace.ID

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Image(systemName: "externaldrive.fill")
                            .foregroundColor(Color.white)
//                            .matchedGeometryEffect(id: "ellipsis", in: namespace)
//                        Spacer()
                    }
//                        .matchedGeometryEffect(id: "image", in: namespace)

                    VStack(alignment: .center) {
//                        blurTags(tags: p.postType, namespace: namespace)
                        Spacer()
                        Text(NSLocalizedString("ApplicationFolder", comment: "The sandbox document folder"))
                            .foregroundColor(Color.textColor)
//                            .matchedGeometryEffect(id: "title", in: namespace)
                        Spacer()
//                        HStack {
//                            Stars(star: 5)
////                                .matchedGeometryEffect(id: "stars", in: namespace)
//                            Text("(100)")
//                                .font(.caption2)
//                                .foregroundColor(.subtextColor)
////                                .matchedGeometryEffect(id: "ratingNum", in: namespace)
//                        }
                    }.padding(.leading)
                    Spacer()
                    VStack {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.white)
//                            .matchedGeometryEffect(id: "ellipsis", in: namespace)
//                        Spacer()
                    }
                }
            }
        }
    }
}
