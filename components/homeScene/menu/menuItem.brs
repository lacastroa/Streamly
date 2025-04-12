sub init()
    m.background = m.top.findNode("itemBackground")
    m.image = m.top.findNode("itemPoster")
end sub

sub showContent()
    itemcontent = m.top.itemContent
    m.image.uri = itemcontent.HDPosterUrl
end sub
