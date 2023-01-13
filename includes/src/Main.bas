Attribute VB_Name = "Main"
Sub Resize_Task_Summary_Table()
    'Refresh Tasks Table
    Worksheets("Tasks_Import").ListObjects("Tasks").Refresh
    
    'Get resize length from imported Index
    wsLength = WorksheetFunction.Max(Sheets("Tasks_Import").ListObjects("Tasks").ListColumns("Index").Range)
        
    'Resize the table UPDATE COLUMNS IF NEEDED
    Sheets("Task_Summary").ListObjects("Task_Summary_Table").Resize Range("A1:I" & wsLength + 1)
End Sub


Sub Update_Date_Totals()
    Dim vRow As Range 'for Row Value
    Dim dateFoundCol, i As Long
    i = 3
    
    Annex_Opened = Range("B3").Value
    Annex_Completed = Range("B4").Value
    Annex_Signed_Off = Range("B5").Value
    
    Historic_Opened = Range("AH3").Value
    Historic_Completed = Range("AH4").Value
    Historic_Signed_Off = Range("AH5").Value
    
    Site_Opened = Range("H3").Value
    Site_Completed = Range("H4").Value
    Site_Signed_Off = Range("H5").Value
    
    West_Tower_Opened = Range("T3").Value
    West_Tower_Completed = Range("T4").Value
    West_Tower_Signed_Off = Range("T5").Value
    
    Other_Opened = Range("N3").Value
    Other_Completed = Range("N4").Value
    Other_Signed_Off = Range("N5").Value

    
    
    
    For Each vRow In Worksheets("Tables").ListObjects("Completed_Over_Time_Table").ListColumns("Date").DataBodyRange.Rows
        ' Use vRow as needed in the loop
        If vRow = Date Then
            dateFoundCol = i
        End If
        
        i = i + 1
    Next vRow
    
    If dateFoundCol Then
        
    Else
    
    End If
    
End Sub

Sub CopyToDatedTable()
    
    Dim TS_Table As ListObject
    Dim TS_DatedTable As ListObject
    Dim tableDateVar As Date
    Dim TS_TableName As String
    Dim dest As Range
    
    tableDateVar = Range("Table_Date").Value
    
    TS_TableName = "TS_" & Format(tableDateVar, "yyyy-MM-dd")
    Sheets.Add(, Sheets(Sheets.Count)).Name = TS_TableName
    
    Set TS_Table = Worksheets("Task_Summary").ListObjects("Task_Summary_Table")
    
    Set dest = Worksheets(TS_TableName).Range("A1")
    TS_Table.Range.Copy
    
    With dest
        .PasteSpecial xlPasteAll
        .PasteSpecial xlPasteColumnWidths
    End With
    
    dest.CurrentRegion.Copy
    dest.PasteSpecial xlPasteValues
    
    Set TS_DatedTable = Worksheets(TS_TableName).ListObjects(1)
    TS_DatedTable.Name = TS_TableName & "_Table"
    
    Worksheets("Tables").ListObjects("TS_Table_Dates_Table").ListRows.Add.Range(1) = tableDateVar
    
End Sub



