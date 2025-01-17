////
//  CardRecent.swift
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

struct CardRecent: View {
    var body: some View {
        Group {
            RecentCardView()
                .padding()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 60)
                .background(BlurView(style: .regular))
                .cornerRadius(10)
                .padding(.vertical, 6)
                .padding(.horizontal)
        }
    }
}

struct CardRecent_Previews: PreviewProvider {
    static var previews: some View {
        CardRecent()
    }
}

struct RecentCardView: View {
    
    @State private var input: [DataObject]
    @State private var isLoading = false
    
    init() {
        self.input = [] // Initialize the input array
    }
    // 添加一个参数 ，入参是(DataObject) ，返回值Void
    // 添加一个参数 ，入参是(DataObject) ，返回值Void
    func onTap(dataObject: DataObject) -> Void {
e        // Your code here
    }    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Image(systemName: "timer")
                            .foregroundColor(Color.white)
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        Text(NSLocalizedString("Recently imported", comment: "Files imported"))
                            .foregroundColor(Color.textColor)
                        Spacer()
                        Button(action: {
                            // Refresh button action
                            
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(Color.white)
                        }
                        
                    }.padding(.leading)
                }.onAppear {
                    print("onAppear")
                    isLoading = true
                    DispatchQueue.global(qos: .background).async {
                        self.input = DataObject.fetchVideoFiles()
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                    }
                }
                
                VStack(alignment: .leading){
                    Divider()
                        .background(Color.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 16)
                    ForEach(input, id: \.self) { item in
                        GoPlay/GoPlay/Modules/SwiftUI/Main/Cards/CardRecent.swift
                                                FileItemView(dataObject: item, onTap: onTap)
                                                Divider()
                            .background(Color.white)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 16)
                    }
                }
                
            }
        }
    }
}
