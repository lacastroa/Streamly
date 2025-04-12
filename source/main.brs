sub main()
    showInitialScreen()
end sub

sub showInitialScreen()
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.setMessagePort(port)
    screen.createScene("mainScene")

    screen.show()

    while(true)
        event = wait(0, port)
        typeEvent = type(event)

        if typeEvent = "roSGScreenEvent"
            if event.isScreenClosed() then return
        end if
    end while
end sub
