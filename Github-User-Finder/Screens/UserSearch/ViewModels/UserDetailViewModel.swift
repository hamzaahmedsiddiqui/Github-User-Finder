//
//  UserDetailViewModel.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
import Foundation

struct UserDetailViewState {
    var name: String?
    var userTag: String
    var avatar: String?
    var bio: String?
    var description: String?
    var location: String?
    var followers, following, repositoryCount: Int?
    var profileURL: String?
    var blogURL: String?

    init(user: User) {
        self.name = user.name
        self.userTag = user.userTag
        self.avatar = user.avatarURL
        self.bio = user.bio
        self.description = user.bio // Assuming this is a similar field (you can modify as needed)
        self.location = user.location
        self.followers = user.followers
        self.following = user.following
        self.repositoryCount = user.publicRepos
        self.profileURL = user.htmlURL
        self.blogURL = user.blog
    }
}

class UserDetailViewModel: ObservableObject {
    @Published var state: UserDetailViewState

    init(user: User) {
        self.state = UserDetailViewState(user: user)
    }
}
