//
//  ContentView.swift
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

import SwiftUI

struct ContentView: View {
    
    // 九九の表に表示する値。初期値は0で埋めておく
    @State var rowValuesArray = [[Int32]](
        repeating: [Int32](repeating: 0, count: 9),count: 9)
    
    var compute = Compute()
    
    var body: some View {
        VStack {
            kukuTableView(rowValuesArray: rowValuesArray).padding(.bottom)
            Button(action: {
                
                self.compute.executeCalc { (result) in
                    if result != nil {
                        self.rowValuesArray = result!
                    }
                }
                
            }){
                Text("Run Compute Pass")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
