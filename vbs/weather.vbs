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
    
    Set ElementTags = responseXml.getElementsByTagName("data")
    Set MaxTemperatures = responseXml.getElementsByTagName("temp2m_max")
    minDates = Array()
    maxDates = Array()
    Temperatures = Array()

    For Each node In ElementTags
        ' WScript.Echo node.GetAttribute("timepoint")
        Set y = node.getElementsByTagName("temp2m_max")
        For Each elem In y
            ' WScript.Echo elem.text
            Temperatures = AddItem(Temperatures, CInt(elem.text))

            i_min = LBound(Temperatures)
            i_max = UBound(Temperatures)

            Max = Temperatures(i_min)
            Min = Temperatures(i_min)
            For i = i_min + 1 To i_max
                If Temperatures(i) > Max Then
                    Max = Temperatures(i)
                ElseIf Temperatures(i) < Min Then
                    Min = Temperatures(i)
                End If
            Next

             If CInt(elem.text) >= Max Then
                 maxDates = AddItem(maxDates, node.GetAttribute("timepoint"))
             ElseIf CInt(elem.text) = Min Then
                 minDates = AddItem(minDates, node.GetAttribute("timepoint"))
             End If
        Next
    Next

    WScript.Echo ""
    WScript.Echo "Max Temperature: " & Max
    WScript.Echo "Dates: "
     For Each val In maxDates
         WScript.Echo val 
     Next

    WScript.Echo ""

    WScript.Echo "Min Temperature: " & Min
    WScript.Echo "Dates: "
     For Each val In minDates
         WScript.Echo val 
     Next
End If