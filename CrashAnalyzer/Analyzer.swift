//
//  Analyzer.swift
//  CrashAnalyzer
//
//  Created by wxiubin on 2019/12/17.
//  Copyright © 2019 wxiubin. All rights reserved.
//

import Cocoa

class Analyzer: NSObject {
    let symbolicatecrash = "/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
    let environment = ["DEVELOPER_DIR": "/Applications/Xcode.app/Contents/Developer"]
    
    public func analyze(dsym: String, crash: String) -> String {
        return shell(launchPath: symbolicatecrash, arguments: [crash, dsym], environment: environment)
    }
}
