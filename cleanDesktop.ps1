<# Initialize Variables #>

<# Desktop path #>
[string]$desktopPath = "C:\Users\Fredrik\Desktop";

<# Destination paths #>
[string]$customDesktopPath = "C:\Users\Fredrik\CustomDesktop\Files";
[string]$imagesFolder = "\Images";
[string]$documentsFolder = "\Documents";
[string]$otherFolder = "\Other";

[string]$imagesPath = $customDesktopPath + $imagesFolder;
[string]$documentsPath = $customDesktopPath + $documentsFolder;
[string]$otherPath = $customDesktopPath + $otherFolder;

[string]$currentYear = Get-Date -f yyyy;
[string]$currentMonth = Get-Date -f MMMM;
[string]$destinationFolder = $currentMonth + "_" + $currentYear;

[string]$fullImagePath = $imagesPath + "\" + $destinationFolder;
[string]$fullDocumentPath = $documentsPath + "\" + $destinationFolder;
[string]$fullOtherPath = $otherPath + "\" + $destinationFolder;

[array]$imageExtensions = @(".png", ".jpg", ".gif", ".svg");
[array]$documentExtensions = @(".txt", ".doc", ".docx", ".pdf", ".odt");

<# Functions #>
function Create-Folder-If-Not_exist {
    param (
        [string]$fullFilePath
    )

    [bool]$doesImageFolderExist = Test-Path -Path $fullFilePath;

    if ($doesImageFolderExist -eq $false) {
        mkdir -Path $fullFilePath;
    }
}

function Move-File {
    param (
        $file, 
        [string]$destinationPath
    )

    [string]$filePath = $desktopPath + "\" + $file.Name;

    [string]$fileDestination = $destinationPath + "\" + $file.Name;
    [bool]$doesFileExist = Test-Path -Path $fileDestination;

    <# Move the file, if the name exist, then change the file name #>
    if ($doesFileExist -eq $false) {
        Move-Item -Path $filePath -Destination $destinationPath;
    } else {
        [int]$i = 0;
        while($doesFileExist -eq $true) {
            $i++;

            $newFileName = $file.BaseName + $i.ToString() + $file.Extension;

            $fileDestination = $destinationPath + "\" + $newFileName;
            $doesFileExist = Test-Path -Path $fileDestination;
        }

        Rename-Item -Path $filePath -NewName $newFileName;
        $filePath = $desktopPath + "\" + $newFileName;
        Move-Item -Path $filePath -Destination $destinationPath;
    }
}

<# Move files #>
$getAllFiles = Get-ChildItem -Path $desktopPath;

forEach($file in $getAllFiles) {

    <# Images #>
    if ($file.Extension -in $imageExtensions) {

        Create-Folder-If-Not_exist -fullFilePath $fullImagePath;

        Move-File -file $file -destinationPath $fullImagePath;
    } 
    <# Documents #>
    elseif ($file.Extension -in $documentExtensions) {

        Create-Folder-If-Not_exist -fullFilePath $fullDocumentPath;

        Move-File -file $file -destinationPath $fullDocumentPath;
    } 
    <# All other files #>
    else {
        
        Create-Folder-If-Not_exist -fullFilePath $fullOtherPath;

        Move-File -file $file -destinationPath $fullOtherPath;
    }
}