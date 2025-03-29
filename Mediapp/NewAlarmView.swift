import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct NewAlarmView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var disease: String = ""
    @State private var interval: String = ""
    @State private var dosage: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                Image("ver1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 180)
                    .clipped()
                    .ignoresSafeArea(edges: .top) 
            }
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
            } else {
                Button("Agregar foto") {
                    showingImagePicker = true
                }
                .frame(width: 200, height: 150)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding()
            }
            
            TextField("Enfermedad", text: $disease)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                TextField("Cada cuánto", text: $interval)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Cantidad", text: $dosage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            Button("Guardar") {
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}
struct NewAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlarmView()
    }
}
