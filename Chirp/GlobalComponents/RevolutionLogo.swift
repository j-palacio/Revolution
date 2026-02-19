//
//  RevolutionLogo.swift
//  Revolution
//
//  Created by Juan Palacio on 21.07.202424.11.2023.
//

import SwiftUI

struct RevolutionLogo: View {
    var frameWidth : CGFloat
    var paddingTop : CGFloat
    var body: some View {

        Image("RevolutionLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: frameWidth)
            .padding(.top, paddingTop)


    }
}

#Preview {
    RevolutionLogo(frameWidth: 30, paddingTop: 15)
}
