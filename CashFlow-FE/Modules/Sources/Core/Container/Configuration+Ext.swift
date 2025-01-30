//
//  File.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/28/25.
//

import Foundation

extension Configuration {
    var info: (serverURL: URL, githubURL: URL) {
        switch type {
        case .debug:
            let testing = settings.environment.testing
            return (URL(string: testing.server)!, URL(string: testing.githubURL)!)
        case .release:
            let prod = settings.environment.production
            return (URL(string: prod.server)!, URL(string: prod.githubURL)!)
        }
    }
}
