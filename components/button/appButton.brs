sub init()
    m.background = m.top.findNode("background")
    m.container = m.top.findNode("container")
    m.label = m.top.findNode("label")
    m.icon = m.top.findNode("icon")
    m.background.uri = "pkg:/images/unfilledButton.png"

    m.top.observeField("focusedChild", "onFocusChanged")
end sub

sub onFocusChanged()
    if m.top.hasFocus() = true then
        m.background.uri = "pkg:/images/filledButton.png"
        m.icon.blendColor = "0x000000"
        m.label.color = "0x000000"
    else
        m.background.uri = "pkg:/images/unfilledButton.png"
        m.icon.blendColor = "0xFFFFFF"
        m.label.color = "0xFFFFFF"
    end if
end sub

sub onLabelChanged()
    m.label.text = m.top.label
end sub
