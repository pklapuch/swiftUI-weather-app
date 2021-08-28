//
//  ChangeDayTimeButton.swift
//  SwiftUI-Weather
//
//  Created by Pawel Klapuch on 8/28/21.
//

import SwiftUI

struct ChangeDayTimeButton: View {
    
    var title: String
    var backgroundColor: UIColor
    var foregroundColor: UIColor
    
    var body: some View {
   
        Text(title)
            .font(.system(size: 20, weight: .medium))
            .frame(width: 280, height: 50)
            .foregroundColor(Color(foregroundColor))
            .background(Color(backgroundColor))
            .cornerRadius(10)
    }
}

struct ChangeDayTimeButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ChangeDayTimeButton(title: "Test Button",
                            backgroundColor: .black,
                            foregroundColor: .white)
    }
}
