//
//  File.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI

struct HomeScreen: View {

    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .spacingLarge) {
                HomeSearchView(query: self.$viewModel.query)
                    .padding([.leading, .trailing, .top], .spacingLarge)

                if !viewModel.isLoading {
                    if viewModel.games.count > 0 {
                        HomeGameList(games: self.viewModel.games)
                    } else {
                        Text("Data not found, try other keyword")
                    }
                } else {
                    Spacer()
                    VStack {
                        ActivityIndicator(isLoading: self.$viewModel.isLoading, style: .large)
                        Text("Loading, please wait")
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .onAppear {
                self.viewModel.discover()
            }
        }.accentColor(.black)
    }
}

struct HomeGameList: View {

    var games: [Game] = []

    var body: some View {
        if #available(iOS 14, *) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(games, id: \.id) { game in
                        NavigationLink(destination: DetailScreen(id: game.id ?? 1)) {
                            ZStack {
                                GameItem(game: game)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            }
        } else {
        List(self.games) { game in
            ZStack(alignment: .center) {
                GameItem(game: game)

                NavigationLink(destination: DetailScreen(id: game.id ?? 0)) {
                    EmptyView()
                }.frame(width: 0, height: 0, alignment: .center)
                    .hidden()
                Spacer()
            }
            .listStyle(PlainListStyle())
        }
        }
    }
}

struct HomeSearchView: View {
    @Binding var query: String
    var body: some View {
        HStack {
            Image.search
            TextField("Search Games", text: $query)
        }
        .padding(.spacingNormal)
        .cornerRadius(.spacingSmall)
    }
}

struct HomePage_Previews: PreviewProvider {
    @State static var queryValue = ""

    static var previews: some View {
        Group {
            HomeScreen()
            HomeSearchView(query: $queryValue).previewLayout(.sizeThatFits)
            HomeGameList(games: [Game.defaultValue]).previewLayout(.sizeThatFits)

        }
    }
}
