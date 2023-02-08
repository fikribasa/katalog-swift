//
//  GameItem.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI
import Kingfisher

struct GameItem: View {

    var game: Game

    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
                    KFImage(URL(string: game.backgroundImage ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height / 4)
                        .cornerRadius(10)
                        .clipped()
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(RoundedCorners(color: Color.black, oppacity: 0.3, topLeft: 0, topRight: 0, bottomLeft: 10, bottomRight: 10))
                                .frame(height: 50)
                                .overlay(VStack(alignment: .leading) {
                                    Text(game.name ?? "")
                                        .fontWeight(.heavy)
                                        .font(.system(.title2))
                                        .lineLimit(1)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                                            HStack(alignment: .center, spacing:0,  content: {
                                        Text("⭐️ \(String(game.rating ?? 0.0))")
                                            .fontWeight(.heavy)
                                            .font(.system(.caption))
                                            .foregroundColor(.white).padding(EdgeInsets(top:0,  leading:20, bottom:2, trailing:10)).frame(alignment:.center)
                                        Text("☄ \(game.released?.convertToString(format: "yyyy") ?? "No data released")")
                                            .fontWeight(.heavy)
                                            .font(.system(.caption))
                                            .foregroundColor(.white).padding(EdgeInsets(top : 0, leading:10, bottom:2, trailing:20)).frame(alignment:.center)
                                    })}, alignment: .leading),
                                    alignment: .bottom
                        )})
            };}

#if DEBUG
struct GameItem_Previews: PreviewProvider {
    static var previews: some View {
        GameItem(game : Game.defaultValue)
            .padding(16)
            .previewLayout(.sizeThatFits)
    }
}
#endif
