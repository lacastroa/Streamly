sub init()
    m.movies = m.top.findNode("movies")
    m.header = m.top.findNode("header")
    m.menu = m.top.findNode("menu")

    m.contentTask = createObject("roSGNode", "contentTask")
    m.contentTask.functionName = "getPopularMovies"
    m.contentTask.control = "RUN"

    m.top.observeField("focusedChild", "onFocusChanged")
    m.movies.observeField("itemFocused", "onItemFocused")
    m.movies.observeField("itemSelected", "onItemSelected")
    m.menu.observeField("event", "onEventChanged")
    m.contentTask.observeField("content", "setContent")

    content = createObject("roSGNode", "moviesContent")
    m.header.content = content

    m.movies.setFocus(true)
    m.lastItemFocused = m.movies
end sub

sub onEventChanged(event as object)
    eventMenu = event.getData()
    m.top.event = eventMenu
end sub

sub setContent(event as object)
    data = event.getData()
    m.movies.content = data
    m.contentTask.control = "STOP"
    m.contentTask.unobserveField("content")
    m.contentTask = invalid
end sub

sub onItemFocused(event as object)
    eventData = event.getData()
    rowContent = m.movies.content.getChild(eventData[0])
    itemContent = rowContent.getChild(eventData[1])

    itemContent.update({
        itemIndex: eventData[1] + 1
        totalItems: rowContent.getChildCount()
    }, true)

    m.header.content = itemContent
end sub


sub onItemSelected(event as object)
    eventData = event.getData()
    rowContent = m.movies.content.getChild(eventData[0])
    itemContent = rowContent.getChild(eventData[1])
    m.top.event = {
        type: "MOVIE_DETAILS"
        data: {
            movieID: itemContent.id,
            itemIndex: eventData[1] + 1,
            totalItems: rowContent.getChildCount()
        }
    }
end sub

sub onFocusChanged()
    if m.top.hasFocus() then
        m.lastItemFocused.setFocus(true)
    end if
end sub

sub onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press = true then
        if key = "right" and m.menu.isInFocusChain() then
            m.movies.setFocus(true)
            m.lastItemFocused = m.movies
            handled = true
        else if key = "left" and m.movies.isInFocusChain() then
            handled = true
            m.menu.setFocus(true)
            m.lastItemFocused = m.menu
        end if
    end if
    return handled
end sub
