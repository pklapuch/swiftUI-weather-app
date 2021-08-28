//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Pawel Klapuch on 8/27/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var date = Date()
    @State private var isNight = false
    
    var body: some View {
        
        ZStack {
            
            SkyBackgroundColor(isNight: $isNight)
            VStack {
                
                VStack {
                    WeatherCityText(city: "Cupertino, CA")
                    WeatherCurrentTemperatureView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                }
                .padding(.bottom, 40)
                
                HStack(spacing: 20) {
                    
                    WeatherDayView(date: $date, index: 0, imageName: "cloud.sun.fill", temperature: 72)
                    WeatherDayView(date: $date, index: 1, imageName: "cloud.snow.fill", temperature: 70)
                    WeatherDayView(date: $date, index: 2, imageName: "cloud.rain.fill", temperature: 71)
                    WeatherDayView(date: $date, index: 3, imageName: "sun.max.fill", temperature: 74)
                    WeatherDayView(date: $date, index: 4, imageName: "wind.snow", temperature: 72)
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: { ChangeDayTimeButton(title: "Change Date Time",
                                               backgroundColor: .white,
                                               foregroundColor: .black) }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewDevice("iPhone 8")
        }
    }
}

struct SkyBackgroundColor: View {

    struct Config {
        
        static let light: [Color] = [.blue, Color("LightBlue")]
        static let dark: [Color] = [.black, .gray]
    }
    
    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: isNight ? Config.dark : Config.light),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherDayView: View {
    
    @Binding var date: Date
    var index: Int
    
    var imageName: String
    var temperature: Int
    
    private let formatter = DateFormatter()
    
    private func getDayShortString() -> String? {
        
        let component = Calendar.current.component(.weekday, from: date) - 1
        let dayIndex = (component + index) % 7
        
        guard let symbols = formatter.shortWeekdaySymbols else { return nil }
        guard symbols.count >= dayIndex else { return nil }
        return symbols[dayIndex]
    }
    
    var body: some View {
        
        VStack {
        
            Text(getDayShortString() ?? "---")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct WeatherCityText: View {
    
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct WeatherCurrentTemperatureView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

