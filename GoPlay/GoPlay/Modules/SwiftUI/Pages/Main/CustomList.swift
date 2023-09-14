////
//  CustomList.swift
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
//  Created by 肖湘 on 2023/8/30.
//  Copyright © 2023 dKingbin. All rights reserved.

import SwiftUI

struct ListData: Identifiable,Hashable {
    var id = UUID()
    var title: String
    var postType: Array<String>
    var date: String
    var Image: String
    var Color: Color
    var percentage: GLfloat
    var stars: Int
}

extension Color {
    static let pinkColor = Color(red: 227 / 255, green: 133 / 255, blue: 180 / 255)
    static let purpleColor = Color(red: 123 / 255, green: 119 / 255, blue: 233 / 255)
    static let OrangeColor = Color(red: 240 / 255, green: 146 / 255, blue: 171 / 255)
    
    
    static let lightPink = Color(red: 236 / 255, green: 188 / 255, blue: 180 / 255)
    static let lightGray = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let lightOrange = Color(red: 219 / 255, green: 98 / 255, blue: 68 / 255)
    static let iconGray = Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255)
    static let lighterPink = Color(red: 233 / 255, green: 219 / 255, blue: 210 / 255)
    static let lighterGray = Color(red: 214 / 255, green: 214 / 255, blue: 214 / 255)
    
    static let textColor = Color(red: 235 / 255, green: 235 / 255, blue: 235 / 255)
    static let subtextColor = Color(red: 199 / 255, green: 199 / 255, blue: 199 / 255)

}
var data = [
    ListData(title: "LazyHGrid in SwiftUI (part 1/3)", postType: ["iOS","SwiftUI", "Xcode"], date: "05 Jun", Image: "LazyGrid",Color: Color.lighterPink, percentage: 0.30, stars: 5),
    ListData(title: "LazyHGrid and LazyVGrid in SwiftUI ", postType: ["iOS","SwiftUI", "Xcode"], date: "15 dec", Image: "LazyGrid2",Color: Color.lighterGray, percentage: 0.25, stars: 4),
    ListData(title: "How to Detect Light/Dark theme", postType: ["iOS","SwiftUI", "Xcode"], date: "20 Nov", Image: "themeDetector",Color: Color.lightOrange, percentage: 0.10, stars: 3),
    ListData(title: "Gradient Color in SWiftUI", postType: ["iOS","SwiftUI", "Xcode"], date: "10 Jun", Image: "try1",Color: Color.lightPink, percentage: 0.45, stars: 2),
    ListData(title: "How to Detect Light/Dark theme", postType: ["iOS","SwiftUI", "Xcode"], date: "05 Feb", Image: "themeDetector",Color: Color.lightGray, percentage: 0.86, stars: 5),
    ListData(title: "LazyHGrid in SwiftUI (part 1/3)", postType: ["iOS","SwiftUI", "Xcode"], date: "15 Dec", Image: "LazyGrid",Color: Color.lightOrange, percentage: 0.30, stars: 3),
    ListData(title: "LazyHGrid and LazyVGrid in SwiftUI ", postType: ["iOS","SwiftUI", "Xcode"], date: "15 dec", Image: "LazyGrid2",Color: Color.lighterPink, percentage: 0.25, stars: 2),
    ListData(title: "How to Detect Light/Dark theme", postType: ["iOS","SwiftUI", "Xcode"], date: "15 dec", Image: "themeDetector",Color: Color.lighterGray, percentage: 0.10, stars: 3),
    ListData(title: "Gradient Color in SWiftUI", postType: ["iOS","SwiftUI", "Xcode"], date: "15 dec", Image: "try1",Color: Color.lightGray, percentage: 0.45, stars: 4),
    ListData(title: "How to Detect Light/Dark theme", postType: ["iOS","SwiftUI", "Xcode"], date: "15 dec", Image: "themeDetector",Color: Color.lightOrange, percentage: 0.86, stars: 5)
]

struct CustomListView: View {
    @State var d = data
    var body: some View {
//        NavigationView {
            List {
                Section(header: GroupedListHeader(), footer: GroupedListFooter()) {
                    ForEach(d, id: \.self) { m in
                        VStack {
                            NavigationLink(destination: Text(m.title)) {
                                HStack{
                                    Image(m.Image)
                                        .resizable()
                                        .frame(width: 120, height: 90)
                                    VStack(alignment: .leading, spacing: 8) {
                                        tags(tags: m.postType)
                                        Text(m.title)
                                            .bold()
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        Text("The Happy Programmer")
                                            .font(.caption2)
                                            .foregroundColor(Color.gray)
                                        HStack {
                                            ProgressView(value: m.percentage)
                                                .progressViewStyle(LinearProgressViewStyle(tint: Color.pinkColor))
                                                .foregroundColor(Color.red)
                                            Text(String(format: "%.0f%%", m.percentage * 100))
                                                .font(.caption2)
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                }
                            }
                        }
                    }.onDelete(perform: self.deleteItem)
                }
            }.listStyle(GroupedListStyle())
//            .navigationTitle("Posts")
//        }
    }

    private func deleteItem(at indexSet: IndexSet) {
            self.d.remove(atOffsets: indexSet)
        }
}

struct GroupedListFooter: View {
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
            Text("Please support me on Patreon")
        }
    }
}
struct GroupedListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "tray.full.fill")
            Text("All Posts from The Happy Programmer")
        }
    }
}

struct tags: View {
    var tags: Array<String>
    var body: some View {
        HStack {
        ForEach(tags, id: \.self) { e in
            Text(e)
                .foregroundColor(.pinkColor)
                .font(.system(size: 6))
                .padding(4)
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.pinkColor, lineWidth: 0.5)
               )
           }
        }
    }
}
