sub init()
    m.header = m.top.findNode("header")
    m.menu = m.top.findNode("menu")
    m.play = m.top.findNode("play")
    m.detailsComponent = m.top.findNode ("detailsComponent")

    setMenuContent()

    m.contentTask = createObject("roSGNode", "contentTask")

    m.top.observeField("focusedChild", "onFocusChanged")
    m.menu.observeField("itemSelected", "onItemSelected")
    m.contentTask.observeField("content", "setContent")

    m.play.setFocus(true)
    m.lastItemFocused = m.play
end sub

sub initDataChanged(event as object)
    data = event.getData()
    movieID = data.movieID
    m.itemIndex = data.itemIndex
    m.totalItems = data.totalItems

    if movieID <> invalid and movieID <> "" then
        m.contentTask.functionName = "getMovie"
        m.contentTask.movieId = movieID
        m.contentTask.control = "RUN"
    end if
end sub

sub setMenuContent()
    menuContent = createObject("roSGNode", "ContentNode")
    menuItem = createObject("roSGNode", "ContentNode")
    menuItem.setFields({
        HDPosterUrl: "pkg:/images/icons/back.png"
    })
    menuContent.appendChild(menuItem)
    m.menu.content = menuContent
end sub

sub setContent(event as object)
    data = event.getData()
    data.update({
        itemIndex: m.itemIndex,
        totalItems: m.totalItems
    })
    m.header.content = data
    m.detailsComponent.content = data
    m.contentTask.control = "STOP"
    m.contentTask.unobserveField("content")
    m.contentTask = invalid
end sub

sub onItemSelected(event as object)
    m.top.event = {
        type: "BACK"
        data: {}
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
            m.play.setFocus(true)
            m.lastItemFocused = m.play
            handled = true
        else if key = "left" and m.play.isInFocusChain() then
            handled = true
            m.menu.setFocus(true)
            m.lastItemFocused = m.menu
        end if
    end if

    return handled
end sub
