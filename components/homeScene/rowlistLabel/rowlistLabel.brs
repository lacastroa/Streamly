sub init()
    m.label = m.top.findNode("label")
end sub

sub onContentChanged()
    content = m.top.content
    m.label.text = content.title
end sub
