//
//  FillView.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 11/03/23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Double
    
    var body: some View {
        VStack {
            Text("\(Int(progress * 100))%")
                .font(.title)
                .foregroundColor(Color.black)
                .padding(.bottom, 10)
                
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 20)
                    .cornerRadius(20)
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: CGFloat(progress) * UIScreen.main.bounds.width / 2, height: 20)
                    .cornerRadius(20)
            }
        }
    }
}

struct FillView: View {
    var body: some View {
        ProgressBar(progress: 0.75)
    }
}


struct FillView_Previews: PreviewProvider {
    static var previews: some View {
        FillView()
    }
}
