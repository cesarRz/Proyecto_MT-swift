//
//  ContentView.swift
//  Proyecto_MT
//
//  Created by Cesar Roman Zuniga on 03/03/23.
//

import SwiftUI


func favorite_message(Message:Bool) -> String {
    if Message{
        return "Unmark Favorite"
    }else{
        return "Mark as Favorite"
    };
}
var votes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func upgrade_vote(index: Int) {
    votes[index] = votes[index] + 1
}

func downgrade_vote(index: Int) {
    votes[index] = votes[index] - 1
}

struct ContentView: View {
    var playerImage = [
        "Zion Williamson",
        "Anthony Davis",
        "Bam Adebayo",
        "Devin Booker",
        "Jae Crowder",
        "Jimmy Butler",
        "John Wall",
        "Kyle Lowry",
        "Luka Doncic",
        "Seth Curry",
        "Stephen Curry",
        "Victor Oladipo"
    ]
    
    var teams = [
        "New Orleans Pelicans",
        "Los Angeles Lakers",
        "Miami Heat",
        "Phoenix Suns",
        "Phoenix Suns",
        "Miami Heat",
        "Los Angles Clippers",
        "Miami Heat",
        "Dallas Mavericks",
        "San Antonio Spurs",
        "Golden State Warriors",
        "Miami Heat"
    ]
    
    var positions = [
        "Power Forward",
        "Power Forward / Center",
        "Center / Power Forward",
        "Shooting Guard",
        "Small Forward / Power Forward",
        "Small Forward / Shooting Guard",
        "Point Guard",
        "Point Guard",
        "Point Guard / Shooting Guard / Small Forward",
        "Shooting Guard / Point Guard",
        "Point Guard",
        "Shooting Guard"
    ]
    
    

    
    @State var FavoritePlayer = Array(repeating: false, count: 21)
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if verticalSizeClass == .regular {
    
            List {
                ForEach(playerImage.indices, id: \.self) {
                    index in FullImageRow(imageName: playerImage[index],
                                          name: playerImage[index],
                                          type: positions[index],
                                          location: teams[index],
                                          index_list: index,
                                          isFavorite: $FavoritePlayer[index]
                                          
                    )
                }
                .listRowSeparator(.hidden)
                .padding(10)
                .cornerRadius(10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
            .listStyle(.plain)
            
        }else if verticalSizeClass == .compact{
            
            List {
                ForEach(playerImage.indices, id: \.self) {
                    index in RowImage(imageName: playerImage[index],
                                          name: playerImage[index],
                                          type: positions[index],
                                          location: teams[index],
                                          index_list: index,
                                          isFavorite: $FavoritePlayer[index]
                                          
                    )
                }
                .listRowSeparator(.hidden)
                .padding(10)
                .cornerRadius(10)
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
            .listStyle(.plain)
            
        }else{
            Text("Error")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .previewDisplayName("Light Side")
            
            ContentView()
                .previewDisplayName("Dark Side")
                .preferredColorScheme(.dark)
        }
}

struct BasicTextImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack (alignment: .leading) {
                Text(name)
                    .font(.system(.title3, design: .rounded))
                
                Text(type)
                    .font(.system(.body))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct FullImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    var index_list: Int;
    
    @State private var showOptions = false;
    @State private var showError = false;
    
    
    @Binding var isFavorite: Bool;
    
    

    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack{
                VStack (alignment: .leading) {
                    Text(name)
                        .font(.system(.title3, design: .rounded))
                    
                    Text(type)
                        .font(.system(.body))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
                Text("\(votes[index_list]) 🗳️")
                
                if isFavorite{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(
                title: Text("What do you want to do?"),
                message: nil,
                buttons: [
                    .default(Text(favorite_message(Message: isFavorite))){
                        self.isFavorite.toggle()
                    },
                    .default(Text("Vote")){
                        upgrade_vote(index: index_list)
                    },
                    .default(Text("Remove Vote")){
                        downgrade_vote(index: index_list)
                    },
                    .default(Text("Review Stats")){
                        self.showError.toggle()
                    },
                    .cancel()
                    
                ]
            
            )
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Not yet available"),
                message: Text("Sorry, this feature is not available yet."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .cancel()
            )
        }
    }
}


struct RowImage: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    var index_list: Int;
    
    @State private var showOptions = false;
    @State private var showError = false;
    
    
    @Binding var isFavorite: Bool;
    
    

    
    var body: some View {
            HStack{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                VStack (alignment: .leading) {
                    Text(name)
                        .font(.system(.title3, design: .rounded))
                    
                    Text(type)
                        .font(.system(.body))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
                Text("\(votes[index_list]) 🗳️")
                
                if isFavorite{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            .onTapGesture {
                showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(
                title: Text("What do you want to do?"),
                message: nil,
                buttons: [
                    .default(Text(favorite_message(Message: isFavorite))){
                        self.isFavorite.toggle()
                    },
                    .default(Text("Vote")){
                        upgrade_vote(index: index_list)
                    },
                    .default(Text("Remove Vote")){
                        downgrade_vote(index: index_list)
                    },
                    .default(Text("Review Stats")){
                        self.showError.toggle()
                    },
                    .cancel()
                    
                ]
            
            )
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Not yet available"),
                message: Text("Sorry, this feature is not available yet."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .cancel()
            )
        }
    }
}

