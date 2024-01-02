//
//  web3.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import SwiftUI

struct web3: View {
    var body: some View {
        VStack{
            WebsiteView(urlString: "https://twitter.com/haikyu_com")
            }
    }
}

struct web3_Previews: PreviewProvider {
    static var previews: some View {
        web3()
    }
}
