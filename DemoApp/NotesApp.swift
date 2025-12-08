//
//  ContentView.swift
//  DemoApp
//
//  Created by students on 08/12/25.
//

import SwiftUI
import SwiftData

struct NotesApp: View {
    @Environment(\.modelContext)
    private var modelContext
    
    @Query private var lists:
    [listt]
    
    @State private var title:String = ""
    @State private var isAlertShowing: Bool = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(lists) { list in
                    Text(list.title)
                }
            }
            .navigationTitle("Notes App")
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isAlertShowing.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
            .alert("Creat a new list", isPresented: $isAlertShowing){
                TextField("Enter a list", text: $title)
                
                Button(){
                    modelContext.insert(listt(title: title))
                    title = ""
                }label: {
                    Text("Save")
                }
            }
            .overlay{
                if lists.isEmpty{
                    ContentUnavailableView("My lists are not available",systemImage: "bin.xmark",
                                           description:  Text("No lists yet. Add one to get started.")
                    )
                }
            }
        }
    }
}
#Preview("Demo Preview"){
    
    let container = try! ModelContainer(
        for: listt.self, configurations:
            ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let ctx = container.mainContext
        ctx.insert(listt(title: "Swift Coding Club"))
        ctx.insert(listt(title: "Good Moring"))
        ctx.insert(listt(title: "Good Afternoon"))
    
     return NotesApp()
        .modelContainer(container)
}


#Preview ("Main Previem") {
    
    
    NotesApp()
}
