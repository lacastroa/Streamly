sub init()
    m.movies = m.top.findNode("movies")

    m.top.observeField("focusedChild", "onFocusChanged")
    m.movies.observeField("rowItemSelected", "onItemSelected")
    m.movies.observeField("rowItemFocused", "onItemFocused")
end sub

sub onFocusChanged()
    if m.top.hasfocus() = true then
        m.movies.setFocus(true)
    end if
end sub
