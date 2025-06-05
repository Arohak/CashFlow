//
//  ListView.swift
//
//
//  Created by Ara Hakobyan on 8/27/23.
//

import SwiftUI

@available(iOS 15, *)
struct ListView: View {
    let models: [Model]

    var body: some View {
        List {
            ForEach(models) { model in
                NavigationLink {
                    DetailView(model: model)
                } label: {
                    ListItemView(model: model)
                }
            }
        }
    }
}

@available(iOS 15, *)
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(models: [.mock, .mock])
    }
}
