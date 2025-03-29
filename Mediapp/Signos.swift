import SwiftUI

struct SignosVitalesView: View {
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
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
            
            Text("Consultar Signos Vitales")
                .font(.title)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
            
            VStack() {
                HStack(spacing: 30) {
                    VStack {
                        Text("Presión Arterial")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(15)
                            .frame(width: 150, height: 125)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        Text("120/80 mmHg")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }

                    VStack {
                        Text("Ritmo Cardíaco")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(15)
                            .frame(width: 150, height: 125)
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        Text("72 bpm")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                }

                HStack(spacing: 30) {
                    VStack {
                        Text("Pasos")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(15)
                            .frame(width: 150, height: 125)
                            .background(Color.orange.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        Text("5000 pasos")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }

                  
                    VStack {
                        Text("Estado Actual")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(15)
                            .frame(width: 150, height: 125)
                            .background(Color.purple.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        
                        Text("Estable")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                    
                }
                
            }
            .padding()

            Spacer()
        }
        
    }
}


struct SignosVitalesView_Previews: PreviewProvider {
    static var previews: some View {
        SignosVitalesView()
    }
}
