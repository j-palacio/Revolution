//
//  ViewHeader.swift
//  Revolution
//
//  Created by Juan Palacio on 21.07.202424.11.2023.
//

import SwiftUI

struct ViewHeader: View {
    //params for this component
    var view : String
    @Binding var searchText: String
    @Binding var showMenu : Bool
    @EnvironmentObject var authManager: AuthManager

    var body: some View {

        ZStack{


            //avatar image
            Group {
                if let avatarUrl = authManager.currentProfile?.avatarUrl, let url = URL(string: avatarUrl) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .cornerRadius(99)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)// Displays the loaded image.
            .onTapGesture {
                withAnimation{
                    showMenu.toggle()
                }
            }
            

            Spacer()
            //based on the view we are gonna render different hero element/s
            switch view{
            case "feed":
                //app logo
                RevolutionLogo(frameWidth: 27, paddingTop: 0).onTapGesture {
                    print("test")
                }
            case "search":
                SearchBar(searchText: $searchText)
            case "community":
                Text("Communities")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            case "notification":
                Text("Notification")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            case "messages":
                Text("Messages")
                    .fontWeight(.bold)
            default:
                //app logo
                RevolutionLogo(frameWidth: 27, paddingTop: 0)
            }
            
            Spacer()
            //icon
            Image(systemName: "gearshape")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(Color(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)))
                .imageScale(.large)
          
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .padding(.leading, 10)
        .padding(.trailing, 10)

        
       
    
            switch view {
            case "feed":
                FeedScreenTabs()
            case "community":
                Text("Discover new communities")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.leading, 10)
                    .font(.title3)
                    .fontWeight(.bold)
            case "notification":
                NotificationsScreenTabs()
            default:
                Text("")
            }
    }
}

//#Preview {
//    ViewHeader(view: "search")
//}
