//
//  web2.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import SwiftUI

struct web2: View {
    var body: some View {
        VStack{
            WebsiteView(urlString: "https://zh.wikipedia.org/zh-tw/排球少年！！")
        }
    }
}

struct web2_Previews: PreviewProvider {
    static var previews: some View {
        web2()
    }
}
