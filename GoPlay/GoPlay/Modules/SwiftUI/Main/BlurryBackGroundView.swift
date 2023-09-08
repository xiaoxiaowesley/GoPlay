////
//  BlurryBackGroundView.swift
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

enum CardPosition: CaseIterable {
    case small, big
}

struct BlurryBackGroundView: View {

    @State var small = true
    @Namespace var namespace
    @State private var position: CardPosition = .small

    var body: some View {
        HStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.pinkColor, Color.purpleColor]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                VStack {
                    Capsule()
                        .fill(Color.OrangeColor)
                        .frame(width: 200, height: 200)
                        .offset(x: -150, y: -55)
                    Spacer()
                    Capsule()
                        .fill(Color.OrangeColor)
                        .frame(width: 200, height: 200)
                        .offset(x: 150, y: 105)
                }
                ScrollView {
                    HStack {
                        Image(systemName: "text.justify")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Spacer()
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 40)
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(Color.white)
                    }.padding(.horizontal)
                    VStack {
                        CardDocument()
                        CardDetector(p: data[0], position: .small)
//                        ForEach(data, id: \.self) { p in
////                            CardDetector(p:p, position: self.position)
//                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
struct BlurryBackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BlurryBackGroundView()
    }
}


struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }
}




struct Previews_BlurryBackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
