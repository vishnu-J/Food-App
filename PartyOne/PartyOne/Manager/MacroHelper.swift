//
//  MacroHelper.swift
//  ios
//
//  Created by apple on 8/27/18.
//  Copyright © 2018 GreedyGame. All rights reserved.
//

import Foundation

internal class MacroHelper{
    
    internal static func applyMacros(url_str : String) -> String {
        let ENCODE_SUFFIX = "_enc]"
        var resolvedUrl : String = url_str
        //let regex = try?NSRegularExpression(pattern: "\\[[a-zA-Z0-9_]+]", options: .caseInsensitive)
        let regex = try?NSRegularExpression(pattern: "(?<!\\{)\\[[a-zA-Z0-9_]+\\](?!\\})", options: .caseInsensitive)
        let url = url_str as NSString
        let range = NSRange(location: 0, length: url_str.count)
        if(!url_str.isEmpty){
            regex?.matches(in: url_str, options: [], range: range).map{
                let macroWithBracket = url.substring(with: $0.range)
                let macroWOBracket = (url.substring(with: $0.range).replacingOccurrences(of: "\\[|_enc\\]$|\\]", with: "", options:.regularExpression, range: nil))
                /*let macroValue : String? = SDKHelper.instance?.getValue(key: macroWOBracket)
                if let macroValue = macroValue{
                    var macro : String
                    var encoded :String? = macroValue
                    if(macroWithBracket.hasSuffix(ENCODE_SUFFIX)){
                        //encoding macros in UTF-8
                        encoded = macroValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    }
                    if let encoded = encoded{
                        macro = encoded
                    }
                    else{
                        macro = macroValue
                    }
                    resolvedUrl = resolvedUrl.replacingOccurrences(of: macroWithBracket, with: macro)
                    resolvedUrl = resolvedUrl.replacingOccurrences(of: "\\{|\\}", with: "", options: .regularExpression, range: nil)
                }*/
            }
        }
        return resolvedUrl
    }
}
