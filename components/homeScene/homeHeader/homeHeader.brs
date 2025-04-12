sub init()
    m.posterHeader = m.top.findNode("posterHeader")
    m.titleHeader = m.top.findNode("titleHeader")
    m.dateHeader = m.top.findNode("dateHeader")
    m.languageHeader = m.top.findNode("languageHeader")
    m.itemHeader = m.top.findNode("itemHeader")
end sub

sub onContentChanged()
    content = m.top.content
    m.posterHeader.uri = "https://image.tmdb.org/t/p/w1920" + content.backdrop_path
    m.titleHeader.text = content.title
    m.dateHeader.text = content.release_date
    m.languageHeader.text = UCase(content.original_language)

    m.itemHeader.text = "Item " + content.itemIndex.toStr() + "/" + content.totalItems.toStr()
end sub
