//
//  FilesManager.swift
//  GoPlay
//
//  Created by xiaoxiang's m1 mbp on 2023/8/28.
//  Copyright © 2023 dKingbin. All rights reserved.
//

import Foundation
import UIKit

class FilesManager: NSObject, UIDocumentPickerDelegate {
    
    static let shared = FilesManager()
    
    private override init() {
        // Initialize any necessary properties
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        
        // 在这里可以使用 selectedFileURL 来访问所选文件的内容
    }
    
    func openFileButtonTapped(viewController:UIViewController) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        viewController.present(documentPicker, animated: true, completion: nil)
    }
}
