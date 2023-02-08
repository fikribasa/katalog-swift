//
//  DetailViewScreen.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import Foundation

class AboutViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var role: String = ""
    @Published var github: String = ""
    @Published var website: String = ""
    @Published var dicodingProfile: String = ""

    func loadData() {
        self.name = UserDefaultHelper.load(forKey: .name) ?? ""
        self.role = UserDefaultHelper.load(forKey: .role) ?? ""
        self.github = UserDefaultHelper.load(forKey: .github) ?? ""
        self.website = UserDefaultHelper.load(forKey: .website) ?? ""
        self.dicodingProfile = UserDefaultHelper.load(forKey: .dicodingProfile) ?? ""
    }

    func saveData() {
        UserDefaultHelper.save(value: self.name, forKey: .name)
        UserDefaultHelper.save(value: self.role, forKey: .role)
        UserDefaultHelper.save(value: self.github, forKey: .github)
        UserDefaultHelper.save(value: self.website, forKey: .website)
        UserDefaultHelper.save(value: self.dicodingProfile, forKey: .dicodingProfile)
    }
}
