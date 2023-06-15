//
//  ContentView.swift
//  TimesTables
//
//  Created by David Granger on 6/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showDetailView: Bool = false
    private let adaptiveColumns = [GridItem(.adaptive(minimum: 170))]
    @State var whichTable: Int = 0
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink], center: .center)
                .ignoresSafeArea()
            VStack (spacing: 5) {
                Spacer(minLength: 20)
                Text("Practice your times tables!")
                    .titleStyle()
                Spacer(minLength: 50)
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(2..<100) { number in
                            Button(action: {
                                whichTable = number
                                showDetailView.toggle()
                            }) {
                                TappableView(number: number)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .sheet(isPresented: $showDetailView) {
                    DetailView(whichTable: $whichTable)
                }
            }
        }
    }
}

extension View {
    func bubbleStyle() -> some View {
        self.modifier(ButtonTextModifier())
    }
    func buttonTextStyle() -> some View {
        self.modifier(TextModifier())
    }
    func titleStyle() -> some View {
        self.modifier(TitleTextModifier())
    }
}

struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}

struct TappableView: View {
    var number: Int
    
    var body: some View {
        Text("\(number)")
            .frame(width: UIScreen.main.bounds.width - 230, height: 60)
            .buttonTextStyle()
            .bubbleStyle()
    }
}

struct ButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .bold()
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
