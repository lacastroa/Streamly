sub init()
    m.search = m.top.findNode("search")

    m.keyboard = createObject("roSgNode", "Keyboard")
    m.keyboard.id = "keyboard"
    m.keyboard.visible = false
    m.keyboard.translation = "[0,600]"
    m.keyboard.keyboardBitmapUri = "pkg:/images/keyboardBackground.png"
    m.keyboard.showTextEditBox = false

    m.top.appendChild(m.keyboard)
    m.top.observeField("focusedChild", "onFocusChanged")
    m.keyboard.textEditBox.observeField("cursorPosition", "onCursorPositionChanged")
    m.keyboard.observeField("text", "onKeyboardTextChanged")
end sub

sub onFocusChanged()
    if m.top.isInFocusChain() = true then
        m.keyboard.visible = true
        m.keyboard.setFocus(true)
        m.search.active = true
    else
        m.keyboard.visible = false
        m.search.active = false
    end if
end sub

sub onCursorPositionChanged()
    if m.keyboard.visible then
        m.top.cursorPosition = m.keyboard.textEditBox.cursorPosition
    end if
end sub

sub onKeyboardTextChanged()
    if m.keyboard.visible then
        m.top.text = m.keyboard.text
    end if
end sub
