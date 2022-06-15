//
//  SecondView.swift
//  Peter002_1
//
//  Created by DONG SHENG on 2022/6/15.
//

import SwiftUI

struct SecondView: View {
    
    @Binding var name: String
    @Binding var age: Double
    @Binding var height: Double
    @Binding var weight: Double
    @Binding var gender: String
    @Binding var constellation: String
    
    var body: some View {
        ZStack {
            
            Color.brown.opacity(0.75).ignoresSafeArea()
            
            VStack(spacing: 20){
                Group{
                    Text("' \(name) '")
                    Text("\(String(format: "%.0f", age))歲")
                    Text("身高:\(String(format: "%.0f", height)) ")
                    Text("體重: \(String(format: "%.0f", weight))")
                    Text("星座: \(constellation)")
            
                }
                    .font(.headline)
                Text("你的配對結果為:")
                    .font(.title)
                
                // 根據 HomeView的 性別 Picker
                // 如果是女的就顯示 Image1(廣志) 若是男 就顯示 Image2(美冴)
                Image(gender == " 女 " ? "Image1" : "Image2")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        // .constant(假的值)    Binding 在預覽畫面用
        SecondView(
            name: .constant("野原廣志"),
            age: .constant(35),
            height: .constant(180),
            weight: .constant(72),
            gender: .constant(" 男 "),
            constellation: .constant(" 牡羊座 "))
    }
}
