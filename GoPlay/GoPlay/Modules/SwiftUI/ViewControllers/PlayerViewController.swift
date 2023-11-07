////
//  PlayerViewController.swift
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
//  Created by 肖湘 on 2023/9/17.
//  Copyright © 2023 dKingbin. All rights reserved.

import Foundation
import UIKit
import SwiftUI

class PlayerViewController: UIViewController {

    var ffView: FFView!
    var ffplay: FFPlay!
    var controlView: VideoView!

    var brightness: Float = 0.0
    var currentPanTime: Float = 0.0
    var duration: Float {
        return self.ffplay.decoder.duration
    }
    
    var vrfilter: FFVRFilter!
    var watermark: FFUIElement!
    var mixfilter: FFAlphaBendFilter!
    
    var isVROpen: Bool = false
    var isWaterMarkOpen: Bool = false
    var anchorVector: GLKVector3 = GLKVector3Make(0, 0, 0)
    var currentVector: GLKVector3 = GLKVector3Make(0, 0, 0)
    var lastQuaternion: GLKQuaternion = GLKQuaternionMake(0, 0, 0, 1)
    var currentQuaternion: GLKQuaternion = GLKQuaternionMake(0, 0, 0, 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        self.currentPanTime = 0.0

        self.isVROpen = false
        self.isWaterMarkOpen = false
        self.lastQuaternion = GLKQuaternionMake(0, 0, 0, 1)
        self.currentQuaternion = GLKQuaternionMake(0, 0, 0, 1)
        
        addSubviews()
        defineLayouts()
        setupVideo()
        setupObservers()
    }
    
    var url: String? {
        didSet {
            ffplay.url = url
        }
    }
    
    func addSubviews() {
        self.view.addSubview(self.ffView)
        self.view.addSubview(self.controlView)

        // Commented out Swift UI integration as this requires more detailed implementation
        // based on the 'VideoCtrlView' SwiftUI implementation
        /**/
        let childView = UIHostingController(rootView: VideoCtrlView())
        addChild(childView)
        childView.view.frame = self.view.bounds
        self.view.addSubview(childView.view)
        childView.didMove(toParent: self)        
    }
    
    func defineLayouts() {
        // Layout code
        // Using `Masonry` in Objective-C typically means using `SnapKit` in Swift.
        // You'd write something similar to the following:
        /*
        self.ffView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        */
        // Note: You'd need to add `SnapKit` to your project for the above code to work.
    }
    
    func setupVideo() {
        // ... (setup video methods)
    }
    
    func setupObservers() {
        // ... (setup observer methods)
    }
    
    // UIResponder methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ... (touchesBegan methods)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ... (touchesMoved methods)
    }
    
    // Notifications and other utility methods here...
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
