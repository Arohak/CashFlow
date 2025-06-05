//
//  Configuration.swift
//  CashFlow FE
//
//  Created by Ara Hakobyan on 1/1/25.
//

import Foundation

public final class Configuration {
    let type: `Type`
    let settings: Settings
    
    init(bundle: Bundle) {
        guard let rawValue = bundle.infoDictionary?["Configuration"] as? String else {
            fatalError("No Configuration Found")
        }
        guard let type = `Type`(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }
        self.type = type
        
        guard let url = bundle.url(forResource: "Settings", withExtension: "plist") else {
            fatalError("Settings file is missing or wrong")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("can't get data from file contents")
        }
        guard let settings = try? PropertyListDecoder().decode(Settings.self, from: data) else {
            fatalError("can't decode model, check keys")
        }
        self.settings = settings
    }

    enum `Type`: String, Sendable {
        case debug, release
    }
    
    struct Settings: Decodable, Sendable {
        let configuration: Configuration
        let environment: Environment
        var common: Common

        struct Configuration: Decodable {
            let debug: Info
            let release: Info

            struct Info: Decodable {
                var fbAppID: String
                var fbClientToken: String
                var googleClientID: String
            }
        }

        struct Environment: Decodable {
            var version: String
            let production: Info
            let testing: Info

            struct Info: Decodable {
                var server: String
                var apiKey: String
                var githubURL: String
            }
        }

        struct Common: Decodable {
            var surveymonkeyURL: String
        }
    }
}
