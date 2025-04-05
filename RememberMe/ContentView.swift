//
//  ContentView.swift
//  RememberMe
//
//  Created by Rishal Bazim on 04/04/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            if let uiImage = UIImage(data: user.photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .imageScale(.large)
            }
            Text(user.name)
        }
    }
}
struct ContentView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showAddView = false
    @State private var previewImage: IdentifiableImage?
    @State private var image: Image?
    @State private var imageData: Data?
    @Query(sort: \User.name) private var users: [User]
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        DetailView(
                            user: user
                        )
                    } label: {
                        UserRow(user: user)

                    }
                }

            }.navigationTitle("Remember Me!").toolbar {
                ToolbarItem {
                    PhotosPicker(selection: $selectedPhoto) {
                        Label("Add", systemImage: "plus.circle.fill")
                    }

                }
            }
        }.sheet(
            item: Binding(
                get: {
                    (previewImage != nil && imageData != nil)
                        ? previewImage : nil
                },
                set: { previewImage = $0 }
            )
        ) { wrapper in
            AddView(image: wrapper.image, imageData: imageData!)
        }

        .onChange(of: selectedPhoto) {
            Task {
                await loadImage()
            }
        }
    }

    func loadImage() async {
        guard
            let imageData = try? await selectedPhoto?.loadTransferable(
                type: Data.self
            ),
            let uiImage = UIImage(data: imageData)
        else {
            return
        }
        self.imageData = imageData
        self.previewImage = IdentifiableImage(image: Image(uiImage: uiImage))

        self.showAddView = true
    }
    func dataToImage(for imageData: Data) -> Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
