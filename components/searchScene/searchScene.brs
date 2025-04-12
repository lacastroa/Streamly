sub init()
    m.movies = m.top.findNode("movies")
    m.leftMenu = m.top.findNode("menu")
    m.searchComponent = m.top.findNode("searchComponent")

    setMenuContent()

    m.contentTask = createObject("roSGNode", "contentTask")
    m.contentTask.functionName = "getSearchcontent"
    m.contentTask.control = "RUN"
    m.contentTask.observeField("content", "setContent")
    m.top.observeField("focusedChild", "onFocusChanged")
    m.leftMenu.observeField("itemSelected", "onItemMenuSelected")

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
    m.top.event = {
        type: "VIDEO_PLAYER"
        data: {}
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