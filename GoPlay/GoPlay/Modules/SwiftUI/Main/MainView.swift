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
                Image(systemName: "1.circle")
                Text("Page 1")
            }
            VStack{
            }
            .onAppear {
                updateTitle(title: "Page Two")
            }
            .tabItem {
                Image(systemName: "2.circle")
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
            
            
             if #available(iOS 13.0, *) {
                if let keyWindow = UIApplication.shared.keyWindow {
                    let statusBar = UIView(frame: keyWindow.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                    statusBar.backgroundColor = backgourndColor
                    keyWindow.addSubview(statusBar)
                }
            } else {
                if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
                    statusBar.backgroundColor = backgourndColor
                }
            }
            
            
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
