//
//  HomeView.swift
//  Peter002_1
//
//  Created by DONG SHENG on 2022/6/15.
//
import SwiftUI

class HomeViewModel: ObservableObject{
    
    @Published var name: String = ""
    
    // SecondView 性別 Binding
    @Published var selection1: String = " 男 " // picker 初始位置 也可以不預設
    let gender: [String] = [
        " 男 " , " 女 "
    ]
    
    @Published var selection2: String = " 處女座 " // picker 初始位置 也可以不預設
    let constellation: [String] = [
        " 摩羯座 " , " 水瓶座 " , " 雙魚座 " , " 牡羊座 " , " 金牛座 " , " 雙子座 " ,
        " 巨蟹座 " , " 獅子座 " , " 處女座 " , " 天秤座 " , " 天蠍座 " , " 射手座 "
    ]
    
    @Published var age: Double = 87.0
    @Published var height: Double = 150.0
    @Published var weight: Double = 100.0
    
    // 重新填寫 選項都重設
    func reset(){
        self.name = ""
        self.age = 87.0
        self.height = 150.0
        self.weight = 100.0
    }
}

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    init(){
        // 初始化時 更改 性別 picker的顏色 (自定義SegmentedPickerStyle)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.brown
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.brown.opacity(0.65).ignoresSafeArea()
                
                VStack(spacing: 12){
                    
                    Text("基本資料")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack(spacing: 0){
                        
                        Text("姓名 :")
                            .font(.title)
                            .padding()
                        
                        VStack(spacing: 2){
                            TextField("請輸入你的全名", text: $viewModel.name)
                                .font(.headline.bold())
                                .foregroundColor(.purple)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                                .padding(.top)
                            
                            Text("最少為 2 個字 !")
                                .font(.callout)
                                .foregroundColor(.red.opacity(0.75))
                                .opacity(viewModel.name.count >= 2 ? 0 : 1)
                            
                        }
                    }
                    .frame(height: 65)
                    
                    HStack(spacing: 0){
                        
                        Text("性別 :")
                            .font(.title)
                            .padding()
                        
                        Picker(selection: $viewModel.selection1) {
                            ForEach(viewModel.gender.indices){ index in
                                Text(viewModel.gender[index])
                                    .tag(viewModel.gender[index])
                            }
                        } label: {
                            // 可省略 (不會顯示)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding()
                        
                    }
                    .frame(height: 65)
                    
                    HStack(spacing: 18){
                        
                        Text("星座 :")
                            .font(.title)
                            .padding()
                        
                        Picker(selection: $viewModel.selection2) {
                            ForEach(viewModel.constellation.indices) { index in
                                Text(viewModel.constellation[index])
                                    .tag(viewModel.constellation[index])
                            }
                        } label: {
                            // 可省略 (不會顯示)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(6)
                        .background(.white)
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                    .frame(height: 65)

                    HStack(spacing: 0){
                        Text("年齡 :")
                            .font(.title)
                            .padding()
                        
                        Text(String(format: "%.0f", viewModel.age)) // 顯示到個數位
                            .font(.title)
                            .padding()
                        
                        Spacer()
                    }
                    .frame(height: 45)
                    
                    // value: Double ,in: 範圍 ,step: 每次增加的量(一單位的間隔)
                    Slider(value: $viewModel.age, in: 1...100 ,step: 1.0)
                        .accentColor(.purple)
                        .padding(.horizontal ,18)
                    
                    HStack(spacing: 0){
                        Text("身高 :")
                            .font(.title)
                            .padding()
                        
                        Text(String(format: "%.1f", viewModel.height)) // 顯示到小數後一位
                            .font(.title)
                            .padding()
                        
                        Spacer()
                    }
                    .frame(height: 45)
                    
                    Slider(value: $viewModel.height, in: 140...200)
                        .accentColor(.pink)
                        .padding(.horizontal ,18)
                    
                    HStack(spacing: 0){
                        Text("體重 :")
                            .font(.title)
                            .padding()
                        
                        Text(String(format: "%.1f", viewModel.weight)) // 顯示到小數後一位
                            .font(.title)
                            .padding()
                        
                        Spacer()
                    }
                    .frame(height: 45)
                    
                    Slider(value: $viewModel.weight, in: 40...120)
                        .accentColor(.blue)
                        .padding(.horizontal ,18)
  
                }
                .padding(.trailing ,15)
                .toolbar{
                    ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar) {
                        Button {
                            viewModel.reset()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .shadow(radius: 1)
                                Text("重新填寫")
                                    .font(.title2)
                            }
                        }
                        .tint(Color.red.opacity(0.85))
                        .shadow(color: .white.opacity(0.65), radius: 1, x: -1, y: -1)
                        .shadow(color: .black.opacity(0.35), radius: 1, x: 1, y: 1)

                        Button {

                        } label: {
                            NavigationLink {
                                SecondView(
                                    name: $viewModel.name,
                                    age: $viewModel.age,
                                    height: $viewModel.height,
                                    weight: $viewModel.weight,
                                    gender: $viewModel.selection1,
                                    constellation: $viewModel.selection2
                                )
                            } label: {
                                
                                HStack {
                                    Text("確認送出")
                                        .font(.title2)
                                        .bold()
                                        .shadow(color: .brown.opacity(0.8), radius: 6, x: 3, y: 3)
                                    
                                    Image(systemName: "dollarsign.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .shadow(radius: 1)
                                }
                                .shadow(color: viewModel.name.count >= 2 ? .black : .black.opacity(0.3) , radius: 2, x: 3, y: 3)
                            }
                        }
                        .tint(Color.white)
                        .padding()
                        .background(.brown)
                        .cornerRadius(8)
                        .shadow(color: viewModel.name.count >= 2 ? .black : .black.opacity(0.3), radius:  2, x: 2, y: 2)
                        .disabled(viewModel.name.count >= 2 ? false : true ) // 判斷 姓名字數要 >= 2 按鈕才能點選
                    }
                }
                .navigationBarHidden(true) // 隱藏 navigationBar 不然會佔空間
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
    }
}
