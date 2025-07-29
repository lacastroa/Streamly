sub init()
    m.categories = m.top.findNode("categories")

    setMenuContent()

    m.top.observeField("focusedChild", "onFocusChanged")
    m.categories.observeField("itemSelected", "onItemMenuSelected")
end sub

sub onFocusChanged()
    if m.top.hasFocus() then
        m.categories.setFocus(true)
    end if
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
    m.top.content = menuContent
end sub

sub onItemMenuSelected(event as object)
    itemSelected = event.getData()
    if itemSelected <> 0 then
        m.top.event = {
            type: "SEARCH"
            data: {}
        }
    else if itemSelected = 0 then
        m.top.event = {
            type: "HOME"
            data: {}
        }

    end if
end sub