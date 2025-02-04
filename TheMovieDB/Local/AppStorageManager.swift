//
//  AppStorageManager.swift
//  SwiftUIActions-Exercise
//
//  Created by Zay Yar Phyo on 19/12/2024.
//

import Foundation

struct AppStorageManager {
    let userDefaults: UserDefaults
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveString(_ data: String, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }

    func getString(forKey key: String) -> String? {
        userDefaults.string(forKey: key)
    }

    func saveObject(_ data: Any, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }

    func getObject(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }

    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
