//
//  ContentView.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI

struct ContentView: View {

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            FavoritePage()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }

            AboutScreen()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
