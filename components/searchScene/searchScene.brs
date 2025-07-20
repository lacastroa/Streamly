sub init()
    m.movies = m.top.findNode("moviess")
    m.leftMenu = m.top.findNode("menu")
    m.searchComponent = m.top.findNode("searchComponent")

    setMenuContent()

    m.contentTask = createObject("roSGNode", "contentTask")
    m.contentTask.functionName = "getSearchContent"
    m.contentTask.control = "RUN"

    m.contentTask.observeField("content", "setContent")
    m.contentTask.control = "RUN"

    m.top.observeField("focusedChild", "onFocusChanged")
    m.leftMenu.observeField("itemSelected", "onItemMenuSelected")
    m.searchComponent.observeField("text", "onSearchTextChanged")
       m.movies.observeField("itemSelected", "onItemSelected")

    m.searchComponent.setFocus(true)
    m.lastItemFocused = m.searchComponent
end sub

sub setMenuContent()
    menuContent = createObject("roSGNode", "ContentNode")
    menuItem1 = createObject("roSGNode", "ContentNode")
    menuItem1.setFields({
        HDPosterUrl: "pkg:/images/icons/home.png"
    })
    menuItem2 = createObject("roSGNode", "ContentNode")
    menuItem2.setFields({
        HDPosterUrl: "pkg:/images/icons/search.png"
    })
    menuContent.appendChild(menuItem1)
    menuContent.appendChild(menuItem2)
    m.leftMenu.content = menuContent
end sub

sub setContent(event as object)
    content = event.getData()
    m.movies.content = content
    m.contentTask.control = "STOP"
    m.contentTask.unobserveField("content")
    m.contentTask = invalid
end sub

sub onSearchTextChanged()
    if m.contentTask = invalid then
        userSearch = m.searchComponent.text
        m.contentTask = createObject("roSGNode", "contentTask")
        m.contentTask.userSearch = userSearch
        m.contentTask.observeField("content", "setContent")
        if userSearch <> "" then
            m.contentTask.functionName = "getSearchContent1"
        else
            m.contentTask.functionName = "getSearchContent"
        end if
        m.contentTask.control = "RUN"
    end if
end sub

sub onItemMenuSelected(event as object)
    itemSelected = event.getData()
    if itemSelected <> 1 then
        m.top.event = {
            type: "HOME"
            data: {}
        }
    end if
end sub

sub onItemSelected(event as object)
    eventData = event.getData()
    itemContent = m.movies.content.getChild(eventData)
    m.top.event = {
        type: "MOVIE_DETAILS"
        data: {
            movieID: itemContent.id,
            itemIndex: eventData + 1,
            totalItems: m.movies.content.getChildCount()
        }
    }
end sub


sub onFocusChanged()
    if m.top.hasFocus() = true then
        m.lastItemFocused.setFocus(true)
    end if
end sub

sub onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press = true then
        if key = "right" and m.leftMenu.isInFocusChain() then
            m.movies.setFocus(true)
            m.lastItemFocused = m.movies
            handled = true
        else if key = "left" and m.movies.isInFocusChain() then
            handled = true
            m.leftMenu.setFocus(true)
        else if key = "up" then
            if m.movies.isInFocusChain() then
                handled = true
                m.searchComponent.setFocus(true)
                m.lastItemFocused = m.searchComponent

            else if m.searchComponent.isInFocusChain() then
                handled = true
                m.movies.setFocus(true)
                m.lastItemFocused = m.movies
            end if
        else if key = "down" and m.searchComponent.isInFocusChain() then
            handled = true
            m.movies.setFocus(true)
        end if
    end if

    return handled
end sub