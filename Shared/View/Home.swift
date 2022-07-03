//
//  Home.swift
//  Analytics Page
//
//  Created by Nguyên Trần on 03/07/2022.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        VStack {
            
            AppBar()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 10) {
                    
                    Text("Total Balance")
                        .fontWeight(.bold)
                    Text("$ 51 200")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                    
                }
                .padding(.top, 20)
                
                
                InComeButton()
                
                // Graph View
                LineGraph(data: smaplePlot)
                    .frame(height: 250)
                
                
                ListCompany()
            }
            
        }
        .background {
            
            Color("bg")
                .ignoresSafeArea()
            
        }
    }
    
    
    @ViewBuilder
    fileprivate func AppBar() -> some View {
        HStack {
            
            Button {
                
            } label: {
                Image("Filter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            
            Spacer()
            
            
            Button {
                
            } label: {
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .frame(width: 50, height: 50)
            }
            
            
        }
        .padding()
    }
    
    @ViewBuilder
    private func ListCompany() -> some View {
        
        VStack {
            
            Text("Shortcuts")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 30) {
                    
                    ForEach(_companies, id: \.id) { company in
                        
                        VStack(spacing: 20) {
                            Image(company.avatar)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                                .foregroundColor(.white)
                                .background {
                                    
                                    Circle()
                                        .fill(LinearGradient(colors: [Color(company.color), Color(company.color).opacity(0.8)], startPoint: .leading, endPoint: .trailing))
                                    
                                }
                            
                            Text(company.name)
                                .font(.callout)
                                .fontWeight(.semibold)
                            
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.white)
                                .shadow(color: .black.opacity(0.03), radius: 5, x: 0, y: 0)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .padding()
        
    }
    
    
    @ViewBuilder
    fileprivate func InComeButton() -> some View {
        Button {
            
        } label: {
            
            Text("Income")
            
            Image(systemName: "chevron.down")
            
        }
        .foregroundColor(.black.opacity(0.8))
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background {
            Capsule()
                .fill(.white)
                .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 0)
        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let smaplePlot: [CGFloat] = [989, 1200, 750, 790, 650, 950, 1200, 600, 500, 600, 890, 1203, 1400, 900, 1250, 1600, 1200]
