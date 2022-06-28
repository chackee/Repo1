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
     WScript.Echo responseXml.xml
    
    'TODO -- check msxml2.domdocument documentation
    ' Maximální "max" teplota v příštím týdnu a datum(y) kdy nastane
    ' Minimální "min" teplota v příštím týdnu a datum(y) kdy nastane
    
    Set ElementTags = responseXml.getElementsByTagName("data")
    minDates = Array()
    maxDates = Array()
    Temperatures = Array()
    Temperatures2 = Array()

    For Each node In ElementTags
        ' WScript.Echo node.GetAttribute("timepoint")
        Set MaxTemperatures = node.getElementsByTagName("temp2m_max")
        Set MinTemperatures = node.getElementsByTagName("temp2m_min")

        For Each elem In MaxTemperatures
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

            If CInt(elem.text) = Max Then
                maxDates = AddItem(maxDates, node.GetAttribute("timepoint"))
            End If
        Next

        For Each elem2 In MinTemperatures
            ' WScript.Echo elem2.text

            Temperatures2 = AddItem(Temperatures2, CInt(elem2.text))

            i_min2 = LBound(Temperatures2)
            i_max2 = UBound(Temperatures2)

            Max2 = Temperatures2(i_min2)
            Min2 = Temperatures2(i_min2)
            For j = i_min2 + 1 To i_max2
                If Temperatures2(j) > Max2 Then
                    Max2 = Temperatures2(j)
                ElseIf Temperatures2(j) < Min2 Then
                    Min2 = Temperatures2(j)
                End If
            Next
            If CInt(elem2.text) = Min2 Then
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

    WScript.Echo "Min Temperature: " & Min2
    WScript.Echo "Dates: "
     For Each val2 In minDates
         WScript.Echo val2 
     Next
End If