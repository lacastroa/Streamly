sub init()
    m.movies = m.top.findNode("movies")

    m.movies.content = createObject("roSGNode", "moviesContent")

    m.top.observeField("focusedChild", "onFocusChanged")
    m.movies.observeField("rowItemSelected", "onItemSelected")
    m.movies.observeField("rowItemFocused", "onItemFocused")
end sub

sub onItemSelected(event as object)
    m.top.itemSelected = event.getData()
end sub

sub onItemFocused(event as object)
    m.top.itemFocused = event.getData()
end sub

sub onFocusChanged()
    if m.top.hasfocus() = true then
        m.movies.setFocus(true)
    end if
end sub
