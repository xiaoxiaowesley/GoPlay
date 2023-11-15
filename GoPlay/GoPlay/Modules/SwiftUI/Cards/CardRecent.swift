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
                .border(Color.black,width: 1.0)
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
    
    func onTap(dataObject: DataObject) {
        let player = PlayViewController()
        player.url = dataObject.fullpath
        let nav = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
        nav?.pushViewController(player, animated: true)
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
                       
                    }.padding(.leading)
                    Spacer()
                    Button(action: {
                        reflesh()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color.white)
                    }
                    
                }.onAppear {
                    print("onAppear")
                    reflesh()
//                    isLoading = true
//                    DataManager.shared.getFiles { dataObjectList in
//                        self.input = dataObjectList
//                        DispatchQueue.main.async {
//                            isLoading = false
//                        }
//                    }
                }
                
                VStack(alignment: .leading){
                    Divider()
                        .background(Color.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 16)
                    ForEach(input, id: \.self) { item in
                        FileItemView(dataObject: item, onTap: onTap)
                        
                        if item != input.last {
                            Divider()
                                .background(Color.white.opacity(0.4))
                                .padding(.vertical, 2)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                
            }
        }
    }
    
    
    func reflesh() {
        isLoading = true
        DataManager.shared.getFiles { dataObjectList in
            self.input = dataObjectList
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}
