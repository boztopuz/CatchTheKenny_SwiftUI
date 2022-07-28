//
//  ContentView.swift
//  CatchTheKenny
//
//  Created by Burak Öztopuz on 27.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var score = 0
    @State var time = 10.0
    @State var x = 75
    @State var y = 250
    @State var showAlert = false
    
    let (x1,y1) = (200,250)
    let (x2,y2) = (200,400)
    let (x3,y3) = (200,100)
    let (x4,y4) = (300,250)
    let (x5,y5) = (300,400)
    let (x6,y6) = (300,100)
    let (x7,y7) = (75,250)
    let (x8,y8) = (75,400)
    let (x9,y9) = (75,100)
    
    var counterTimer : Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if time <= 0.5 {
                self.showAlert = true
            }else{
                self.time -= 1
            }
        }
    }
    
    var timer : Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            let array = [(self.x1,self.y1),(self.x2,self.y2),(self.x3,self.y3),(self.x4,self.y4),(self.x5,self.y5),(self.x6,self.y6),(self.x7,self.y7),(self.x8,self.y8),(self.x9,self.y9),]
            
            var previousNumber : Int?
            
            func generateRandom() -> Int{
                var randomNumber = Int(arc4random_uniform(UInt32(array.count - 1)))
                
                while previousNumber == randomNumber {
                    randomNumber = Int(arc4random_uniform(UInt32(array.count - 1)))
                }
                
                previousNumber = randomNumber
                
                return randomNumber
            }
            
            self.x = array[generateRandom()].0
            self.y = array[generateRandom()].1
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 150)
            Text("Catch The Kenny")
                .font(.largeTitle)
            
            HStack {
                Text("Time Left: ")
                    .font(.headline)
                Text(String(self.time))
                    .font(.headline)
            }
            
            HStack{
                Text("Score: ")
                    .font(.headline)
                Text(String(self.score))
                    .font(.headline)
            }
            Spacer()
            
            Image("kenny")
                .resizable()
                .frame(width: 250, height: 170)
                .position(x: CGFloat(self.x), y: CGFloat(self.y))
                .gesture(TapGesture(count: 1).onEnded({ () in
                    self.score += 1
                }))
                .onAppear{
                    _ = self.timer
                    _ = self.counterTimer
                }
                
            Spacer()
        }.alert(isPresented: $showAlert){
            return Alert(title: Text("Time Over"), message: Text("Play Again?"), primaryButton: Alert.Button.default(Text("OK"),action: {
                self.score = 0
                self.time = 10.0
            }), secondaryButton: Alert.Button.cancel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
