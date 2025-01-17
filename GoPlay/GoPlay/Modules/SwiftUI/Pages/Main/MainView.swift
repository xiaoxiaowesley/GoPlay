//
//  MainView.swift
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
                BlurryBackGroundView()
            }
            .onAppear {
                updateTitle(title: "Main")
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text(NSLocalizedString("Main", comment: "Main page"))
            }
            
            VStack{
                
                NoSpaceList()
                
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
            updateNaviBarColor(title: Color.white, background: .turquoise)
        }
    }
    
    func updateTitle(title:String){
        let controller = hostingProvider.viewController
        controller?.title = title
    }
    
    func updateNaviBarColor(title:Color,background:Color){
        
        let controller = hostingProvider.viewController
        
        if controller?.navigationController != nil {
        }
    }
    
}


struct MainView_Previews: PreviewProvider {
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

