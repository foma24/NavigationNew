import Foundation

public struct Post {
    public var title: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public let post1 = Post(title: "Post1",
                 description: "Desription1",
                 image: "chip", likes: 0, views: 0)
public let post2 = Post(title: "Post2",
                 description: "Desription2",
                 image: "duck", likes: 0, views: 0)
public let post3 = Post(title: "Post3",
                 description: "Desription3",
                 image: "ghostbusters", likes: 0, views: 0)
public let post4 = Post(title: "Post4",
                 description: "Desription5",
                 image: "mario", likes: 0, views: 0)

public var postArray: [Post] = [post1, post2, post3, post4]
