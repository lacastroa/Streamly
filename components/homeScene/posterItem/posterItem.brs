sub init()
    m.posterImage = m.top.findNode("posterImage")
end sub

sub showContent()
    itemcontent = m.top.itemContent
    m.posterImage.uri = "https://image.tmdb.org/t/p/w200" + itemcontent.poster_path
end sub
