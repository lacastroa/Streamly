sub init()
    m.scenes = m.top.findNode("scenes")

    m.router = Router()
    m.router.initialize(m.scenes)
    m.router.navigateToScene("homeScene", {}, false)
end sub

sub routingEventCallback(event as object)
    eventData = event.getData()

    if eventData.type = "MOVIE_DETAILS" then
        m.router.navigateToScene("detailsScene", eventData.data, false)
    else if eventData.type = "BACK" then
        m.router.navigateToPreviousScene()
    else if eventData.type = "SEARCH" then
        m.router.navigateToScene("searchScene", eventData.data, false)
    else if eventData.type = "HOME" then
        m.router.navigateToScene("homeScene", eventData.data, false)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press = true and key = "back" then
        m.router.navigateToPreviousScene()
        handled = true
    end if

    return handled
end function
