//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Soro on 2022-10-12.
//

import SwiftUI

struct NewTaskItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task : String = ""
    @Binding var isShowing: Bool
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
      
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 16){
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24,weight: .bold,design: .rounded))
                    .padding()
                    .background(isDarkMode ? Color(UIColor.tertiarySystemBackground).cornerRadius(10) : Color(UIColor.secondarySystemBackground).cornerRadius(10)
                        )
                
                Button {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)

                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24,weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled{
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? .blue : Color.pink)
                .cornerRadius(10)
                
            }
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
            .cornerRadius(15)
            .shadow(radius: 24)
            .frame(maxWidth: 640)
            
        }
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
