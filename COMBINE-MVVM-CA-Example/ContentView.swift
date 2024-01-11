//
//  ContentView.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 4/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        PostListView(viewModel: ViewModelFactory().makePostViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
