//
//  ContentView.swift
//  FlatUI
//
//  Created by xiaoxiang's m1 mbp on 2023/8/24.
//

import SwiftUI


struct MainView: View {

    var body: some View {
        TabView {
//             NavigationView {
                VStack{
                    ListView()
                }
                .navigationBarTitle("Page One", displayMode: .inline)
                .onAppear {
                    
                }
//            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Page 1")
            }

//            NavigationView {
                VStack{
//                    NavigationLink(destination: SettingView()) {
//                           Text("跳转到详情页")
//                       }
                }
                .navigationBarTitle("Page Two", displayMode: .inline)
                .onAppear {
                }
//            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Page 2")
            }
        }
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: .white, background:UIColor(FUColors.turquoise))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
extension UINavigationBarAppearance {
    func setColor(title: UIColor? = nil, background: UIColor? = nil) {
        configureWithTransparentBackground()
        if let titleColor = title {
            largeTitleTextAttributes = [.foregroundColor: titleColor]
            titleTextAttributes = [.foregroundColor: titleColor]
        }
        backgroundColor = background
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

