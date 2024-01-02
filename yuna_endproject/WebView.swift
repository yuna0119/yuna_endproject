//
//  WebView.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import SwiftUI


struct WebView: View {
    var body:some View{
        NavigationView{
            ScrollView(.vertical){
                Spacer()
                Spacer()
                let columns=[GridItem(),GridItem()]
                LazyVGrid(columns:columns){
                    NavigationLink(destination:web1()){
                        VStack{
    
                            Image("日向")
                            .resizable()
                            .scaledToFill().frame(width: 150, height: 150)
                            .cornerRadius(15).clipped()
                            .transition(.opacity)

                            Text("Game")}
                    }
                    NavigationLink(destination:web2()){
                        VStack{
    
                            Image("影山")
                            .resizable()
                            .scaledToFill().frame(width: 150, height: 150).cornerRadius(15).clipped().transition(.opacity)

                            Text("Wiki")}
                    }
                    NavigationLink(destination:web3()){
                        VStack{
    
                            Image("龍")
                            .resizable()
                            .scaledToFill().frame(width: 150, height: 150).cornerRadius(15).clipped().transition(.opacity)

                            Text("Twitter")}
                    }
                    NavigationLink(destination:web4()){
                        VStack{
    
                            Image("西谷")
                            .resizable()
                            .scaledToFill().frame(width: 150, height: 150).cornerRadius(15).clipped().transition(.opacity)

                        Text("Movies")}
                    }
                            .navigationTitle("Website").navigationBarTitleDisplayMode(.inline)
                            
                        }
                        
                            
                    
                }.background(Image("BG").scaledToFit().opacity(0.5))
            }

        }
            
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
