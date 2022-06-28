Function getWeatherForWeekXml(londitute, latitude, byRef outputXml)
    const weatherApiUrl = "http://www.7timer.info/bin/api.pl"
    const weatherApiProduct = "civillight"
    Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    strUrl = weatherApiUrl & _
            "?lon=" & Replace(CStr(londitute),",",".") & _ 
            "&lat=" & Replace(CStr(latitude),",",".") & _ 
            "&product=" & weatherApiProduct & _ 
            "&output=xml"
    With xmlHttp
        .open "GET", strUrl, False
        .SetRequestHeader "accept", "application/xml"
        .send
    End With
    outputXml.loadXml(xmlHttp.responseText)
    getWeatherForWeekXml = (xmlHttp.status = 200)
End Function

Function AddItem(arr, val)
    ReDim Preserve arr(UBound(arr) + 1)
    arr(UBound(arr)) = val
    AddItem = arr
End Function



Dim lon, lat, responseXml
lon = 50.0493559
lat = 14.4371824
Set responseXml = CreateObject("Msxml2.DOMDocument.6.0")

If getWeatherForWeekXml(lon,lat,responseXml) Then
    ' WScript.Echo responseXml.xml
    
    'TODO -- check msxml2.domdocument documentation
    ' Maximální "max" teplota v příštím týdnu a datum(y) kdy nastane
    ' Minimální "min" teplota v příštím týdnu a datum(y) kdy nastane
    
    Set x = responseXml.getElementsByTagName("data")
    Set MaxTemperatures = responseXml.getElementsByTagName("temp2m_max")
    Dim maxValue, count, datum
    maxValue = 0
    a = Array()
    b = Array()

' maximal value

    For Each node In x
        ' WScript.Echo node.GetAttribute("timepoint")
        Set y = node.getElementsByTagName("temp2m_max")
        For Each elem In y
            ' WScript.Echo elem.text
            if CInt(elem.text) > maxValue Then
                maxValue = elem.text
                a = AddItem(a, maxValue)
                b = AddItem(b, node.GetAttribute("timepoint"))

            End If
        Next
    Next

    WScript.Echo "Temperature: " & maxValue
    WScript.Echo "Dates: "
    For Each val In b
        WScript.Echo val 
    Next

End If