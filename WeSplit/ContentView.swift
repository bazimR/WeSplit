//
//  ContentView.swift
//  WeSplit
//
//  Created by Rishal Bazim on 15/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 25
    @FocusState private var isAmountFocused:Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var finalAmount : Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let amountPerPerson = (checkAmount+tipValue)/peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format:
                                .currency(
                                    code: Locale.current.currency?.identifier ?? "USD"
                                )
                    ).keyboardType(.decimalPad).focused($isAmountFocused)
                    Picker("Select number of people",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much would you like to tip") {
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(tipPercentages,id:\.self){
                            Text($0,format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section{
                    Text(
                        finalAmount,
                        format:
                                .currency(
                                    code: Locale.current.currency?.identifier
                                    ?? "USD")
                    )
                }
            }.navigationTitle("WeSplit").toolbar{
                if isAmountFocused {
                    Button("Done"){
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
