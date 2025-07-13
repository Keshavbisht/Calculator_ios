import SwiftUI

struct ContentView2: View {
    @State private var curr: String = ""
    @State private var ans: String = "0"
    @State private var prev: String = ""
    @State private var currentOperator: String = ""

    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack(alignment: .trailing) {
                Text(ans)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                    .padding(.trailing)
                
                VStack(spacing: -30) {
                    Spacer()
                    
                    HStack(spacing: -30) {
                        circleButton(Name: "AC")
                        circleButton(Name: "back")
                        operation(Name: "%")
                        operation(Name: "/")
                    }.padding(.trailing, 5.0)
                    
                    HStack(spacing: -30) {
                        numberButton(Name: "1")
                        numberButton(Name: "2")
                        numberButton(Name: "3")
                        operation(Name: "+")
                    }
                    
                    HStack(spacing: -30) {
                        numberButton(Name: "4")
                        numberButton(Name: "5")
                        numberButton(Name: "6")
                        operation(Name: "-")
                    }
                    
                    HStack(spacing: -30) {
                        numberButton(Name: "7")
                        numberButton(Name: "8")
                        numberButton(Name: "9")
                        operation(Name: "x")
                    }
                    
                    HStack(spacing: -30) {
                        numberButton(Name: "0")
                        enterButton(Name: "=")
                    }
                }
            }
        }
    }

    // MARK: - Button Functions

    func numberButton(Name: String) -> some View {
        Button(action: {
            curr += Name
            ans = curr
        }) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                Text(Name)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
            }.padding()
        }
    }

    func operation(Name: String) -> some View {
        Button(action: {
            if Name == "%" {
                if let val = Double(curr) {
                    ans = String(val / 100)
                    curr = ans
                }
            } else {
                prev = curr
                curr = ""
                currentOperator = Name
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 93, height: 100)
                Text(Name)
                    .foregroundColor(.orange)
                    .font(.system(size: 40))
            }.padding()
        }
    }

    func enterButton(Name: String) -> some View {
        Button(action: {
            calculateResult()
        }) {
            ZStack {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 296, height: 100)
                Text(Name)
                    .foregroundColor(.black)
                    .font(.system(size: 40))
            }.padding()
        }
    }

    func circleButton(Name: String) -> some View {
        Button(action: {
            if Name == "AC" {
                curr = ""
                prev = ""
                ans = "0"
                currentOperator = ""
            } else if Name == "back" {
                if !curr.isEmpty {
                    curr.removeLast()
                    ans = curr.isEmpty ? "0" : curr
                }
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                Text(Name)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
            }.padding()
        }
    }

    // MARK: - Core Logic

    func calculateResult() {
        guard let num1 = Double(prev), let num2 = Double(curr) else {
            ans = "Error"
            return
        }

        var result: Double = 0

        switch currentOperator {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "x":
            result = num1 * num2
        case "/":
            if num2 == 0 {
                ans = "∞"
                return
            }
            result = num1 / num2
        default:
            ans = "?"
            return
        }

        let intResult = Int(result)
        ans = result == Double(intResult) ? String(intResult) : String(result)
        curr = ans
    }
}

#Preview {
    ContentView2()
}
