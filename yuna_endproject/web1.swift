//
//  web1.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import SwiftUI

struct web1: View {
    var body: some View {
        VStack{
        WebsiteView(urlString: "https://play.google.com/store/apps/details?id=com.gholdings.haikyu&hl=zh_TW&gl=US")
        }
    }
}

struct web1_Previews: PreviewProvider {
    static var previews: some View {
        web1()
    }
}
