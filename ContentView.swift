//  Created by Lucas Real Dias on 27/03/23.

import SwiftUI

struct ContentView: View {
    
    // Estilização do título da NavigationView
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 50, weight: .ultraLight)
        ]
    }
    
    @State private var tableNumberString = ""
    @State private var tableNumber = 0
    @State private var result = ""
    @State var showSheet = false
    
    // Foco do TextField
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack{
            VStack{
                NavigationView {
                    Form {
                        Section {
                            
                            TextField(
                                "Number",
                                text: $tableNumberString,
                                prompt: Text("Ex: 32"))
                            .font(.system(size: 25))
                            .padding(5)
                            .foregroundColor(.gray)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                            
                            Button("Calcular") {
                                stringToInt()
                                result = calculate(tableNumber)
                                showSheet.toggle()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 25))
                            .padding(.bottom, 12)
                            
                            // Sheet content
                            .sheet(isPresented: $showSheet) {
                                
                                Button(action: {
                                    resetTextField()
                                    showSheet.toggle()}) {
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 25))
                                .padding(.top, -10)
                                .padding(20)
                                
                                Text("Tabuada do \(tableNumberString)")
                                    .padding(23)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 40).weight(.ultraLight))
                                    .padding(.top, -15)
                                    .padding(.bottom, 20)
                                
                                Text(calculate(Int(tableNumberString) ?? 0))
                                    .font(.system(size: 22).weight(.ultraLight))
                            }
                            
                        } header: {
                            Text("Digite um número")
                        }
                        .font(.system(size: 15))
                        .padding(.top, 20)
                    }
                    .navigationTitle("Tabuada App")
                    
                    // Botão para fechar teclado
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isFocused = false
                            }
                        }
                    }
                }
                
                Image(systemName: "compass.drawing")
                    .font(.system(size: 250))
                    .padding(.bottom, 50)
                    .foregroundColor(ColorAsset.bgImg)
                    .opacity(0.8)
            }
            .background(ColorAsset.bg)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

extension ContentView {
    
    func stringToInt() {
        tableNumber = Int(tableNumberString) ?? 0
    }
    
    func calculate(_ number: Int) -> String {
        var table = ""
        for i in 1...20 {
            table += "\(number) x \(i) = \(number * i)\n"
        }
        return table
    }
    
    func resetTextField() {
        if showSheet == true {
            tableNumberString = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
