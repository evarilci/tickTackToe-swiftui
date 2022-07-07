//
//  gridView.swift
//  shadowView
//
//  Created by Eymen Varilci on 7.07.2022.
//

import SwiftUI

struct gridView: View {
    
    // Moves
    @State var moves : [String] = Array(repeating: "", count: 9)
    
    // identifying the current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    
    var body: some View {
        
        VStack{
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15),count: 3),spacing: 15) {
                ForEach(0..<9,id: \.self){index in
                    ZStack{
                        Color.blue
                        
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                            .opacity(moves[index] != "" ? 1 : 0)
                        
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (0.0, 1.0, 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0)
                    
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    }
                }
            }
            .padding(15)
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play Again"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }
    
    func checkWinner(){
        
        if checkMoves(player: "X"){
            msg = "X won !!!"
            gameOver.toggle()
            
        }
        
        else if checkMoves(player: "O"){
            msg = "O won !!!"
            gameOver.toggle()
            
        }
        
        else {
            let status = moves.contains { (value) -> Bool in
                
                return value == ""
            }
            if !status{
                msg = "game over"
                gameOver.toggle()
            }
        }
        
    }
    
    func checkMoves(player: String)->Bool{
        
        // checking horizontal
        for i in stride(from: 0, to: 9, by: 3){
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player {
                
                return true
            }
        }
        // checking vertical
        for i in 0...2{
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player {
                return true
            }
        }
        
        // checking diagonal
        
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        
        
        return false
    }
}


func getWidth()->CGFloat{
    let width = UIScreen.main.bounds.width - (30 + 30)
    return width / 3
}
