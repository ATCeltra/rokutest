' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********
Library "Roku_Ads.brs"

function Main() as void
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
    PlayContentWithCSAS(scene)
end function

sub PlayContentWithCSAS(scene as Object)
    adUrl = "https://ads.celtra.com/3a65d563/vast.xml?externalAdServer=Custom&tagVersion=url-standard-7&vastVersion=3.0"
    videoUrl = "https://test-andrejtratnik.s3.eu-central-1.amazonaws.com/celtra_all_hands_2021___ljubljana+(1080p).mp4"
    m.adIface = Roku_Ads() 'RAF initialize
    m.adIface.enableAdMeasurements(true)
    m.adIface.setContentGenre("Entertainment")
    m.adIface.setContentId("Celtra" )
    m.adIface.setContentLength(170)

    m.adIface.SetDebugOutput(true) 'for debug purpose
    m.adIface.SetAdPrefs(false)
    m.adIface.SetAdURL(adUrl)

    m.adPods = m.adIface.GetAds()
    myContentNode = createObject("roSgNode", "ContentNode")
    myContentNode.url = videoUrl
    myContentNode.length = 170
    'myContentNode.streamFormat = "hls"

    csasStream = m.adIface.constructStitchedStream(myContentNode, m.adPods)
    m.adIface.renderStitchedStream(csasStream, scene)
end sub
