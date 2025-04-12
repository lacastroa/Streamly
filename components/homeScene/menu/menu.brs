sub init()
    m.categories = m.top.findNode("categories")
    m.top.observeField("focusedChild", "onFocusChanged")
    m.categories.observeField("itemSelected", "onItemSelected")
end sub

sub onFocusChanged()
    if m.top.hasFocus() then
        m.categories.setFocus(true)
    end if
end sub

sub onItemSelected(event as object)
    m.top.itemSelected = event.getData()
end sub
