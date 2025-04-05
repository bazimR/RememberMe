//
//  DetailView.swift
//  RememberMeTests
//
//  Created by Rishal Bazim on 05/04/25.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var body: some View {
        VStack(spacing: 20) {
            if let image = dataToImage(for: user.photo) {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(.circle)
                    .shadow(radius: 10)
                    .padding(.top)
            }
            Spacer()
        }.navigationTitle(user.name)
    }

    func dataToImage(for imageData: Data) -> Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }

}

#Preview {
    //    DetailView(image: .init(systemName: "photo"))
}
