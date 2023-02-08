//
//  DetailScreen.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI
import Kingfisher

struct DetailScreen: View {

    @ObservedObject var viewModel: DetailViewModel = DetailViewModel()
    var id: Int
    init(id: Int) {
        self.id = id
    }

    var body: some View {
        VStack {
            if self.viewModel.game != nil {
                DetailGame(viewModel: viewModel, game: self.viewModel.game!)
            } else {
                VStack {
                    ActivityIndicator(isLoading: self.$viewModel.isLoading, style: .large)
                    Text("Loading, please wait")
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.getDetailGame(gameID: self.id)
        })
    }
}

struct DetailGame: View {

    @ObservedObject var viewModel: DetailViewModel
    @State private var confirmationShown = false
    var game: Game
    private func addToFavorite() {
        self.viewModel.addToFavoriteList(game: self.game)
    }

    private func removeFromFavorite() {
        self.viewModel.removeFavorite(gameID: self.game.id ?? 0)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                Spacer()
                KFImage(URL(string: game.backgroundImage ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: 250,  alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    Spacer()
                }
                Group {
                    HStack(content: {
                Text(game.name ?? "No name")
                    .fontWeight(.heavy)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        if self.viewModel.isFavorite {
                            Button(
                                action: { self.confirmationShown = true},
                            label: {
                                Image(systemName: "heart.fill").resizable()
                                    .foregroundColor(.red)
                                    .aspectRatio(1, contentMode: .fit).frame(width: 30, height: 30)
                            }).alert(isPresented:$confirmationShown) {
                                Alert(
                                    title: Text("Konfirmasi"),
                                    message: Text("Apakah anda yakin untuk menghapus item ini dari favorit?"),
                                    primaryButton: .destructive(Text("Hapus")) {
                                        self.removeFromFavorite()
                                        self.confirmationShown = false
                                    },
                                    secondaryButton: .cancel(Text("Batal"))
                                )
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .frame(alignment: .trailing)
                        } else {
                            Button(action: {
                                self.addToFavorite()
                            }, label: {
                                Image(systemName: "heart").resizable().foregroundColor(.red)
                                    .aspectRatio(1, contentMode: .fit).frame(width: 30, height: 30)
                            }).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).frame(alignment: .trailing)
                        }
                    })
                Divider()
                    HStack(alignment: .top, spacing: 50) {
                    VStack(alignment: .center) {
                        Text("Rating")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.rating ?? 0.0))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    VStack(alignment: .center) {
                        Text("Metascore")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(String(game.metaScore ?? 0))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                Divider()
                    HStack( spacing: 50, content: {
                    Text("Released Date : ").fontWeight(.bold)
                        .foregroundColor(.gray).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Text("\(game.released?.convertToString(format: "MMM dd, yyyy") ?? "No data released")")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                Divider()
                HStack( spacing: 50, content: {
                    Text("Genre : ")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Text(game.getGenre()).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)).frame(maxWidth: .infinity, alignment: .trailing)
                })
                    Divider()
                    Spacer()}
                Text("About")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    .font(.title2)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                Spacer()
                Text(game.description ?? "No description")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Divider()
            }
            .navigationBarTitle("Detail", displayMode: .inline)
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(id: 1)
    }
}
