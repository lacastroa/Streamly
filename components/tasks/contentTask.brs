sub init()
end sub

sub getJsonFile()
    fileContent = ReadAsciiFile(m.top.jsonFilePath)
    jsonObject = ParseJson(fileContent)
    m.top.content = jsonObject
end sub


sub setRequest(url as string)
    headers = {
        "Accept": "application/json"
        "Authorization": "Bearer " + "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNmJiZGM1MGY3NTFlNjRkZGNiMWY3ZDEwZTIyZGU0MiIsIm5iZiI6MTc0NDMyODE5My41NDMsInN1YiI6IjY3Zjg1NjAxMWJjNjM5NTY2YWQ5YzY0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HKPKUPS84hHaoPtUOesYkzxeUBp5F6ckq1c5fb9xQrc"
    }
    m.urlTransfer = createObject("roUrlTransfer")
    m.urlTransfer.setUrl(url)
    m.urlTransfer.setRequest("GET")
    m.urlTransfer.retainBodyOnError(true)
    m.urlTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
    m.urlTransfer.initClientCertificates()
    m.urlTransfer.enableEncodings(true)
    m.urlTransfer.setHeaders(headers)
end sub

sub getPopularMovies()
    setRequest("https://api.themoviedb.org/3/movie/popular")
    response = m.urlTransfer.getToString()
    json = ParseJson(response)

    content = CreateObject("RoSGNode", "ContentNode")
    rowContent = CreateObject("RoSGNode", "ContentNode")
    rowContent.title = "Most Popular"

    for each item in json.results
        contentChild = CreateObject("RoSGNode", "moviesContent")
        contentChild.update(item)
        rowContent.appendChild(contentChild)
    end for

    content.appendChild(rowContent)

    m.top.content = content
end sub

sub getMovie()
    movieId = m.top.movieId
    movieUrl = "https://api.themoviedb.org/3/movie/" + movieId
    setRequest(movieUrl)

    response = m.urlTransfer.getToString()
    json = ParseJson(response)

    movieContent = CreateObject("RoSGNode", "moviesContent")
    movieContent.update(json)
    m.top.content = movieContent
end sub

sub getSearchContent()
 setRequest("https://api.themoviedb.org/3/movie/popular")
    response = m.urlTransfer.getToString()
    json = ParseJson(response)

    content = CreateObject("RoSGNode", "ContentNode")

    for each item in json.results
        contentChild = CreateObject("RoSGNode", "moviesContent")
        contentChild.update(item)
        content.appendChild(contentChild)
    end for

    m.top.content = content
end sub


sub getSearchContent1()
 setRequest("https://api.themoviedb.org/3/search/movie?query=" + m.top.userSearch)
    response = m.urlTransfer.getToString()
    json = ParseJson(response)

    content = CreateObject("RoSGNode", "ContentNode")

    for each item in json.results
        contentChild = CreateObject("RoSGNode", "moviesContent")
        contentChild.update(item)
        content.appendChild(contentChild)
    end for

    m.top.content = content
end sub