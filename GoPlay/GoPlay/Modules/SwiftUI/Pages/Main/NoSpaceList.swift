////
//  NoSpaceList.swift
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
//  Created by 肖湘 on 2023/8/31.
//  Copyright © 2023 dKingbin. All rights reserved.

import SwiftUI

//extension Color {
//    static let lightPink = Color(red: 236 / 255, green: 188 / 255, blue: 180 / 255)
//    static let lightGray = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
//    static let lightOrange = Color(red: 219 / 255, green: 98 / 255, blue: 68 / 255)
//    static let iconGray = Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255)
//    static let lighterPink = Color(red: 233 / 255, green: 219 / 255, blue: 210 / 255)
//    static let lighterGray = Color(red: 214 / 255, green: 214 / 255, blue: 214 / 255)
//}


struct NoSpaceList: View {

    var body: some View {
        GeometryReader { g in
            NavigationView {
                ScrollView {
                    HStack {
                        Image(systemName: "square.grid.3x3.fill")
                            .font(.title3)
                        Spacer()
                        Text("The Happy Programmer")
                            .font(.title3)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                    }.padding().ignoresSafeArea()

                    VStack {
                        ForEach(data) { post in
                            NavigationLink(destination: NospaceListDestination(post: post)) {
                                HStack{
                                    HStack(alignment: .firstTextBaseline) {
                                        VStack(alignment: .leading) {
                                            Text(post.title)
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            nospaceTags(tags: post.postType)
                                            Spacer()
                                            Divider().frame(height: 0.5).background(Color.black)
                                            HStack {
                                                Text("Post Updated")
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                Text(post.date)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                            }.padding(.bottom, 20)
                                        }.padding(.top, 30)

                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.iconGray)
                                            .font(.largeTitle)
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(width: g.size.width, height: g.size.height / 2.5)
                                .background(post.Color)
                            }

                        }
                    }
                }.frame(width: g.size.width, height: g.size.height)
                .navigationBarHidden(true)
            }
        }
    }
}
struct NoSpaceList_Previews: PreviewProvider {
    static var previews: some View {
        NoSpaceList()
    }
}


struct nospaceTags: View {

    var tags: Array<String>

    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text("\(tag)")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .foregroundColor(.black)
            }
        }
    }
}


struct NospaceListDestination: View {
    @Environment(\.presentationMode) var presentationMode
    var post : ListData
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    ZStack(alignment: .top) {
                        post.Color
                        Image(post.Image)
                            .resizable()
                            .frame(width: g.size.width, height: g.size.height / 2.3)

//                            .overlay(LinearGradient(gradient: Gradient(colors: [post.Color, post.Color.opacity(0.1)]), startPoint: .bottom, endPoint: .top))
                            .overlay(post.Color.opacity(0.5))
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(post.Color.opacity(0.1))
                                    .cornerRadius(100)
                            })
                            Spacer()
                            Button(action: {

                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(post.Color.opacity(0.1))
                                    .cornerRadius(50)
                            })
                        }

                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    }.frame(height: g.size.height / 2.3)
                    HStack {
                        Text("Post Updated")
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer()
                        Text(post.date)
                            .font(.caption)
                            .foregroundColor(.black)
                    }.padding(.horizontal)
                    .padding(.vertical, 10)
                    VStack(alignment: .leading,spacing: 30) {
                        Text(post.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("One advanced diverted domestic sex repeated bringing you old. Possible procured her trifling laughter thoughts property she met way. Companions shy had solicitude favourable own.").lineSpacing(10)
                    }.padding()
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Read More")
                                .padding(.trailing)
                            Image(systemName: "arrow.right")

                            Spacer()
                        }.padding()
                        .border(Color.black, width: 1)
                        .padding()
                        .foregroundColor(.black)
                    }.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }
            }
        }
        .navigationBarHidden(true)
        .background(post.Color)
        .ignoresSafeArea(edges: [.top,.bottom])
    }
}
