////
//  DataObject.swift
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
//  Created by 肖湘 on 2023/9/13.
//  Copyright © 2023 dKingbin. All rights reserved.

import Foundation

@objc class FileInfo: NSObject {
    private var _filename: String
    var filename: String {
        get {
            return _filename
        }
        set {
            _filename = newValue
        }
    }
    
    private var _fullpath: String
    var fullpath: String {
        get {
            return _fullpath
        }
        set {
            _fullpath = newValue
        }
    }
    
    private var _time: Int64
    var time: Int64 {
        get {
            return _time
        }
        set {
            _time = newValue
        }
    }
    // add a property name timeString which is use time to convert into "yyyy/MM/dd" format
    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(_time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    init(filename: String, fullpath: String, time: Int64) {
        self._filename = filename
        self._fullpath = fullpath
        self._time = time
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(fullpath)
        hasher.combine(filename)
        hasher.combine(time)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? FileInfo else {
            return false
        }
        return fullpath == other.fullpath && filename == other.filename && time == other.time
    }
}
