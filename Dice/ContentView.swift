//
//  ContentView.swift
//  Dice
//
//  Created by Pieter Jooste on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject var diceManager = DiceManager()
    
    @State private var angle = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:Gradient(colors:[.blue, .orange]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Dice")
                    .font(.largeTitle)
                    .padding(20)
                    .foregroundColor(.black)
                
                Stepper("Select sides: \(diceManager.sides)", value: $diceManager.sides, in: 6...100, step: 1)
                    .padding(.horizontal, 100)
                    .foregroundColor(.white)
                
                Button {
                    diceManager.feedback.prepare()
                    diceManager.rollDice()
                    if voiceOverEnabled {
                        angle = 0
                    } else {
                        angle += 360
                    }
                } label: {
                    Image(systemName: "dice")
                        .font(.largeTitle)
                        .padding(20)
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                .rotationEffect(.degrees(angle))
                .animation(.easeIn, value: angle)
                .accessibilityLabel("Press the button to throw the dice")
                    
                Text("Throw \(diceManager.throwNumber): \(diceManager.diceNumber)")
                    .frame(width: 180, height: 120)
                    .font(.title)
                    .foregroundColor(.black)
                
                Button("Start Again", action: diceManager.reset)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                
                ScrollView {
                    ForEach(diceManager.throwArray, id: \.self) { dice in
                        HStack {
                            Text("\(dice.throwNumber).")
                            Text(" \(dice.diceNumber)")
                            Text(" max: \(dice.sides)")
                            Text(" Total: \(dice.total)")
                        }
                        .padding(10)
                    }
                }
                .onAppear(perform: diceManager.loadData)
    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
