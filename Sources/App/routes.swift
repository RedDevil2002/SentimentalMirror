import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("tweet", ":content") { req in
        guard let content = req.parameters.get("content") else { throw Abort(.internalServerError) }
        return "\(content)"
    }
}
