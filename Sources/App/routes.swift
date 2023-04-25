import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("tweet", ":status") { req in
        guard let status = req.parameters.get("status") else { throw Abort(.internalServerError) }
        Task {
            let bot = TwitterBot()
            bot.createTweet(status)
        }
        return "bot tweeted \(status)"
    }
    
    app.post("tweet") { req in
        
        Task {
            guard let status = try? req.content.decode(TwitterBot.Tweet.self).status else { throw Abort(.internalServerError) }
            let bot = TwitterBot()
            bot.createTweet(status)
        }
        return Response(status: .accepted, version: .http3, body: Response.Body(stringLiteral: "Accepted"))
    }
}
