//
//  kukuTableView.swift
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

import SwiftUI

struct kukuTableView: View {
    
    let rowValuesArray: [[Int32]]
    
    var body: some View {
        VStack {
            ForEach(rowValuesArray, id: \.self) { rowValues in kukuRowView(rowValues: rowValues)
            }
        }
    }
}

struct kukuTableView_Previews: PreviewProvider {
    static var previews: some View {
        kukuTableView(rowValuesArray: [
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
            [1,2,3,4,5,6,7,8,9],
        ])
    }
}
