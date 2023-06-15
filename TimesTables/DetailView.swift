//
//  DetailView.swift
//  TimesTables
//
//  Created by David Granger on 6/5/23.
//

import SwiftUI

private let adaptiveColumns = [GridItem(.adaptive(minimum: 170))]

struct DetailView: View {
    
    @Binding var whichTable: Int
    
    @State var result: String = ""
    @State var userScore: Int = 0
    @State var randomNumber: Int = Int.random(in: 1...12)
    
    private var rightAnswer: Int {
        self.whichTable * self.randomNumber
    }
    private var arrayAnswers: [Int] {
        return self.generateAnswers(rightAnswer: self.rightAnswer)
    }
    
    func generateAnswers(rightAnswer: Int) -> [Int] {
        let lowerBound = max(1, rightAnswer - 5)
        let upperBound = rightAnswer + 5
        var incorrectAnswers = Set<Int>()
        while incorrectAnswers.count < 3 {
            let randomIncorrectAnswer = Int.random(in: lowerBound...upperBound)
            if randomIncorrectAnswer != rightAnswer {
                incorrectAnswers.insert(randomIncorrectAnswer)
            }
        }
        
        incorrectAnswers.insert(rightAnswer)
        return Array(incorrectAnswers)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("\(whichTable) times tables!")
                    .titleStyle()
                Spacer()
                    .frame(height: 20)
                Text("What is \(whichTable) * \(randomNumber)?")
                    .frame(width: UIScreen.main.bounds.width)
                    .background(.thickMaterial)
                    .font(.largeTitle)
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(arrayAnswers, id: \.self) { number in
                        Button {
                            buttonLogic(number)
                        } label: {
                            Text("\(number)")
                        }
                        .frame(width: UIScreen.main.bounds.width - 230, height: 60)
                        .buttonTextStyle()
                        .bubbleStyle()
                    }
                }
                .padding(.horizontal)
                Text("\(result)")
                    .titleStyle()
                Text("Score: \(userScore)")
                    .titleStyle()
            }
        }
    }
    
    func buttonLogic(_ number: Int) {
        if number == rightAnswer {
            userScore += 1
            randomNumber = Int.random(in: 1...12)
            result = "Correct!"
        } else {
            result = "Incorrect, try again!"
        }
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        DetailView(whichTable: .constant(5))
    }
}
