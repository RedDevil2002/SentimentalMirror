# SentimentalMirror

## How to start the project

- cd into the project directory
- type this command ```open Package.swift```

## Usage (How to make an HTTP request using tools like postman)
### Base URL is https://http://127.0.0.1:8080/

### Post Something
- URL: https://http://127.0.0.1:8080//tweet
- Method: Post
- Content in JSON
```
{
  "status": "YOUR CONTENT HERE"
} 
```
- It will return a sentimental analysis based on the content that you just posted. (scaled from -20 to 20)
