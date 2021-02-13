//
//  kukuRowView.swift
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

import SwiftUI

struct kukuRowView: View {
    
    var rowValues: [Int32]
    
    var body: some View {
        HStack {
            ForEach(rowValues, id: \.self) {
                value in kukuCellView(value: value)
            }
        }
    }
}

struct kukuRowView_Previews: PreviewProvider {
    static var previews: some View {
        kukuRowView(rowValues: [1,2,3,4,5,6,7,8,9])
    }
}
