//
//  button.swift
//  dicoding-katalog
//
//  Created by User on 9/5/21.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(Color.red80)
            .cornerRadius(16)

    }
}

struct ButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
        }) {
            Text("Text")
        }.modifier(ButtonModifier()).padding()
    }
}
