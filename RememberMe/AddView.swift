import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var image: Image
    var imageData: Data
    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(.circle)
                    .shadow(radius: 10)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter Name")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    TextField("Name", text: $name)
                        .padding()
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    Color.secondary.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                }
                .padding(.horizontal)
                Button(action: {
                    // Save logic here
                    print("Saved: \(name)")

                    let newUser = User(name: name, photo: imageData)
                    modelContext.insert(newUser)

                    dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(
                            name.isEmpty
                                ? Color.white.opacity(0.4)
                                : Color
                                    .white
                        )
                        .background(
                            name.isEmpty ? Color.gray : Color.accentColor
                        )
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                .padding(.bottom)
                .disabled(name.isEmpty)

                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            })
            .padding(.bottom)
            .background(Color(UIColor.secondarySystemBackground))
            .navigationTitle("Add Member")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    NavigationView {
        AddView(
            image: Image(systemName: "person.circle.fill"),
            imageData: Data()
        )
    }
}
