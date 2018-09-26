//
//  URL.swift
//  Pods
//
//  Created by Jérôme Danthinne on 26/09/2018.
//

import Foundation

extension URL {
    
    public func parseMailto() -> (email: String, subject: String?, body: String?)? {
        guard scheme == "mailto",
            let parts = absoluteString.split(separator: ":").last?.split(separator: "?"),
            let email = parts.first
            else { return nil }
        
        var subject: String?
        var body: String?
        
        if parts.count == 2, let query = parts.last {
            let queryArguments = query.split(separator: "&").compactMap({ argument -> [Substring.SubSequence]? in
                let argumentParts = argument.split(separator: "=")
                return argumentParts.count == 2 ? argumentParts : nil
            })
            if let subjectString = queryArguments.first(where: { $0[0] == "subject" })?.last {
                subject = String(subjectString).removingPercentEncoding
            }
            if let bodyString = queryArguments.first(where: { $0[0] == "body" })?.last {
                body = String(bodyString).removingPercentEncoding
            }
        }
        
        return (email: String(email), subject: subject, body: body)
    }
    
}
