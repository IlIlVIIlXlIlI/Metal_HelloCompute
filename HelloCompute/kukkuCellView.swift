//
//  kukuCellView.swift
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

import SwiftUI

struct kukuCellView: View {
    
    var value: Int32
    
    var body: some View {
        ZStack {
            Text("\(self.value)")
                .frame(width: 23,
                       height: 25,
                       alignment: .center)
                .padding(4)
                .background(GeometryReader { geometry in
                    Path { path in
                        let x: CGFloat = -4.0
                        let w = geometry.size.width + 8
                        let h = geometry.size.height
                        let rt = CGRect(x: x,
                                        y: 0,
                                        width: w,
                                        height: h)
                        path.addRect(rt)
                    }
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(red: 0.8,
                                           green: 0.8,
                                           blue: 0.8))
                    
                })
        }
    }
}

struct kukuCellView_Previews: PreviewProvider {
    static var previews: some View {
        kukuCellView(value: 99)
    }
}
