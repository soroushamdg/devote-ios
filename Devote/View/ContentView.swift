//
//  ContentView.swift
//  Devote
//
//  Created by Soro on 2022-10-11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false
    
    @State var task:String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // fetching data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
             
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    //body
    var body: some View {
        NavigationView {
            ZStack{
                // Main View
                VStack{
                    // Header
                    HStack(spacing: 10) {
                        Text("Devote")
                            .font(.system(.largeTitle,design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16,weight: .semibold,design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule().stroke(Color.white,lineWidth: 2))
                        
                        
                        Button {
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24,height: 24)
                                .font(.system(.title,design: .rounded))
                        }

                    }.padding().foregroundColor(.white)
                    
                    Spacer(minLength: 80)
               
                    // New task button
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,weight: .semibold,design: .rounded))
                        Text("New task".uppercased())
                            .font(.system(size: 24,weight: .bold,design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.pink,.blue]), startPoint: .leading, endPoint: .trailing).clipShape(Capsule())
                    )
                    .shadow(radius: 12)
                    
                // Tasks
                List {
                    ForEach(items) { item in
                        ListRowItemView(item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
                .shadow(radius: 12)
                .listStyle(InsetGroupedListStyle())
                .padding(.vertical,0)
                .frame(maxWidth: 640)
                .scrollContentBackground(.hidden)
                    
            }
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
                print("background color is clear now")
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
        }
        .navigationViewStyle(.stack)
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
