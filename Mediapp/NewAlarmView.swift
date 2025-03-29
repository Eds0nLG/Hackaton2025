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
    @State private var duracion: String = ""
    @Environment(\.presentationMode) var presentationMode

    @Binding var alarms: [Alarm] // Binding a la lista de alarmas

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

            // Mostrar la imagen seleccionada si existe
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
            } else {
                // Botón para seleccionar una imagen
                Button("Agregar foto") {
                    showingImagePicker = true
                }
                .frame(width: 200, height: 150)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding()
            }

            // Campo de texto para la enfermedad
            TextField("Enfermedad", text: $disease)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Campos de texto para el intervalo y la dosis
            HStack {
                TextField("Cada cuánto(hrs)", text: $interval)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Cantidad", text: $dosage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            HStack {
                TextField("Duracion (horas)", text: $duracion)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }


            // Botón de guardar
            Button("Guardar") {
                // Crear una nueva alarma con los datos proporcionados
                let newAlarm = Alarm(medicine: disease, time: interval, taken: false)
                alarms.append(newAlarm)  // Agregar la nueva alarma a la lista

                // Aquí podrías guardar la imagen en algún modelo o base de datos si es necesario

                // Volver a la vista anterior
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
        // Lista de alarmas de ejemplo para el preview
        let alarms = Binding(
            get: {
                return [
                    Alarm(medicine: "Aspirina", time: "Cada 6 horas", taken: false),
                    Alarm(medicine: "Ibuprofeno", time: "Cada 8 horas", taken: false)
                ]
            },
            set: { _ in }
        )

        // Pasar el Binding de alarms al NewAlarmView
        return NewAlarmView(alarms: alarms)
    }
}

