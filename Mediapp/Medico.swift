import SwiftUI

struct Medico: Identifiable {
    let id = UUID()
    var nombre: String
    var telefono: String
    var especialidad: String
}

struct ContactarMedicoView: View {
    @State private var nombre = ""
    @State private var telefono = ""
    @State private var especialidad = ""
    @State private var medicos: [Medico] = [
        Medico(nombre: "Armando", telefono: "1234567890", especialidad: "Oftalmólogo"),
        Medico(nombre: "Josué", telefono: "0987654321", especialidad: "Cardiólogo"),
        Medico(nombre: "Uriel", telefono: "1112223333", especialidad: "Fisioterapia"),
        Medico(nombre: "María", telefono: "4445556666", especialidad: "Dermatología")
    ]
    
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
            VStack {
                Text("Agregar Médico")
                    .font(.title2)
                    .bold()
                TextField("Nombre", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Teléfono", text: $telefono)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                TextField("Especialidad", text: $especialidad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Guardar") {
                    guard !nombre.isEmpty, !telefono.isEmpty, !especialidad.isEmpty else { return }
                    let nuevoMedico = Medico(nombre: nombre, telefono: telefono, especialidad: especialidad)
                    medicos.append(nuevoMedico)
                    nombre = ""
                    telefono = ""
                    especialidad = ""
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()
            
            // Lista de médicos guardados
            List(medicos) { medico in
                HStack {
                    VStack(alignment: .leading) {
                        Text(medico.nombre)
                            .font(.headline)
                        Text(medico.especialidad)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // Botón para llamar al médico
                    Button(action: {
                        // Asegurarse de que la URL sea válida para realizar la llamada
                        if let phoneURL = URL(string: "tel://\(medico.telefono)"), UIApplication.shared.canOpenURL(phoneURL) {
                            UIApplication.shared.open(phoneURL)
                        }
                    }) {
                        // Icono de teléfono verde
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)
                            .padding()
                            .background(Circle().fill(Color.green.opacity(0.2)))
                    }
                }
            }
        }
        
    }
}

struct ContactarMedicoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactarMedicoView()
    }
}
