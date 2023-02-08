//
//  FavouriteView.swift
//  dicoding-katalog
//
//  Created by User on 10/3/21.
//

import SwiftUI

struct FavoritePage: View {

    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if self.viewModel.games.count > 0 {
                    List(self.viewModel.games) { game in
                        ZStack {
                            GameItem(game: game)

                            NavigationLink(destination: DetailScreen(id: game.id ?? 0)) {
                                EmptyView()
                            }.frame(width: 0, height: 0, alignment: .center)
                                .hidden()
                        }
                    }
                } else {
                    Text("Tidak ada data di dalam daftar favorite")
                }
            }
            .onAppear {
                self.viewModel.getFavoriteGame()
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
