//
//  ContentView.swift
//  FlatUI
//
//  Created by xiaoxiang's m1 mbp on 2023/8/24.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var hostingProvider: ViewControllerProvider
    
    var body: some View {
        
        TabView {
            VStack{
                FolderTypeList()
            }
            .onAppear {
                updateTitle(title: "Page One")
            }
            .tabItem {
                Image(systemName: "play.fill")
                Text("Page 1")
            }
            VStack{
                Text("\u{e600}\u{e601}\u{e602}\u{e603}\u{e604}\u{e605}\u{e606}\u{e607}\u{e608}\u{e609}\u{e60a}\u{e60b}\u{e60c}\u{e60d}\u{e60e}\u{e60f}\u{e610}\u{e611}\u{e612}\u{e613}\u{e614}\u{e615}\u{e616}\u{e617}\u{e618}\u{e619}\u{e61a}\u{e61b}\u{e61c}\u{e61d}\u{e61e}\u{e61f}\u{e620}\u{e621}\u{e622}\u{e623}\u{e624}\u{e625}\u{e626}\u{e627}\u{e628}\u{e629}\u{e62a}\u{e62b}\u{e62c}\u{e62d}\u{e62e}\u{e62f}\u{e630}\u{e631}\u{e632}\u{e633}\u{e634}\u{e635}\u{e636}\u{e637}\u{e638}\u{e639}\u{e63a}\u{e63b}\u{e63c}\u{e63d}\u{e63e}\u{e63f}\u{e640}\u{e641}\u{e642}\u{e643}\u{e644}\u{e645}")
                .font(.custom("flat-ui-pro-icons", size: 20))
                .foregroundColor(.red)
                
                
            }
            .onAppear {
                updateTitle(title: "Page Two")
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Page 2")
            }
        }
        .onAppear {
            updateNaviBarColor(title: Color.white, background: FUColors.turquoise)
        }
    }
    
    func updateTitle(title:String){
        let controller = hostingProvider.viewController
        controller?.title = title
    }
    
    func updateNaviBarColor(title:Color,background:Color){
        
        let controller = hostingProvider.viewController
        
        if let navi = controller?.navigationController {
            
            let backgourndColor = UIColor(background)
            let titleColor = UIColor(title)
            
//
//             if #available(iOS 13.0, *) {
//                if let keyWindow = UIApplication.shared.keyWindow {
//                    let statusBar = UIView(frame: keyWindow.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
//                    statusBar.backgroundColor = backgourndColor
//                    keyWindow.addSubview(statusBar)
//                }
//            } else {
//                if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
//                    statusBar.backgroundColor = backgourndColor
//                }
//            }
            
            
            if #available(iOS 15.0, *) {
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithTransparentBackground()
                navigationBarAppearance.backgroundColor = backgourndColor
                navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
                navi.navigationBar.standardAppearance = navigationBarAppearance
                navi.navigationBar.compactAppearance = navigationBarAppearance
                navi.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            }else{
                navi.navigationBar.tintColor = titleColor
                navi.navigationBar.backgroundColor = backgourndColor
                navi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        .environmentObject(ViewControllerProvider())
    }
}


extension View {
    func embeddedInHostingController() -> UIHostingController<some View> {
        let provider = ViewControllerProvider()
        let hostingAccessingView = environmentObject(provider)
        let hostingController = UIHostingController(rootView: hostingAccessingView)
        provider.viewController = hostingController
        return hostingController
    }
}

final class ViewControllerProvider: ObservableObject {
    fileprivate(set) weak var viewController: UIViewController?
}

