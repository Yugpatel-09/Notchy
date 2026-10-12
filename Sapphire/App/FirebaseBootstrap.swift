//
//  FirebaseBootstrap.swift
//  Sapphire
//
//  Created by Shariq Charolia on 2026-09-14

import FirebaseAppCheck
import FirebaseCore

@MainActor
enum FirebaseBootstrap {
    private(set) static var isConfigured = false

    static func configureIfNeeded() {
        guard !isConfigured else { return }
        guard let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let apiKey = plist["API_KEY"] as? String, !apiKey.isEmpty else {
            print("[FirebaseBootstrap] Stub/empty GoogleService-Info.plist detected. Skipping Firebase initialization.")
            return
        }
        #if DEBUG
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #else
        AppCheck.setAppCheckProviderFactory(DeviceCheckProviderFactory())
        #endif
        FirebaseApp.configure()
        isConfigured = true
    }
}