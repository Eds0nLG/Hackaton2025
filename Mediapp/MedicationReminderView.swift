import SwiftUI

struct MedicationReminderView: View {
    @State private var alarms = [
        Alarm(medicine: "Paracetamol", time: "5", taken: false),
        Alarm(medicine: "Aspirina", time: "8", taken: false)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("ver1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 180)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                }
                
                ForEach(alarms.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(alarms[index].medicine)
                                .font(.headline)
                            Text("Dentro de: \(alarms[index].time) horas")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            alarms[index].taken.toggle()
                        }) {
                            Image(systemName: alarms[index].taken ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                NavigationLink(destination: NewAlarmView(alarms: $alarms)) {  // Pasar el binding de alarms
                    Text("Establecer nueva alarma")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: ContactarMedicoView()) {
                    Text("Contactar médico")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: SignosVitalesView()) {
                    Text("Tomar signos vitales")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct Alarm {
    var medicine: String
    var time: String
    var taken: Bool
}

struct MedicationReminderView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationReminderView()
    }
}
