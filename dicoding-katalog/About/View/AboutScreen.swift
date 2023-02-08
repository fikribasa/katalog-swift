//
//  DetailScreen.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2, content: {
            Image("user")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(100)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 30, trailing: 10))
            Text("Muhammad Fikri Basa")
                .font(.title3)
                .fontWeight(.bold).padding(EdgeInsets(top: 0, leading:0, bottom:20, trailing: 0))
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:20) {
                Link(destination: URL(string: "https://www.linkedin.com/in/fikribasa/")!) {
                    Image("linkedin")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(5)
                }
                Link(destination: URL(string: "https://www.dicoding.com/users/fikribasa")!) {
                    Image("dicoding")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(5)
                }
            }
            Spacer()
        })
        .navigationTitle("Profile")
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
