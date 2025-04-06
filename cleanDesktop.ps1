<# Initialize Variables #>
<# Initialize Variables #>
[string]$desktopPath = "C:\Users\Fredrik\Desktop";
[string]$customDesktopPath = "C:\Users\Fredrik\CustomDesktop\Files";

[string]$imagesFolder = "\Images";

[string]$imagesPath = $customDesktopPath + $imagesFolder;

[string]$currentYear = Get-Date -f yyyy;
[string]$currentMonth = Get-Date -f MMMM;
[string]$destinationFolder = $currentMonth + "_" + $currentYear;

[string]$fullImagePath = $imagesPath + "\" + $destinationFolder;

<# Move files #>
$getAllFiles = Get-ChildItem -Path $desktopPath;

forEach($file in $getAllFiles) {

    <# Images #>
    if ($file.Extension -eq ".png" -or ".jpg" -or "gif" -or "svg") {

        <# Check if folder exist, if not, then create it #>
        [bool]$doesImageFolderExist = Test-Path -Path $fullImagePath;
        if ($doesImageFolderExist -eq $false) {
            mkdir -Path $fullImagePath;
        }

        <# Move image to folder #>
        $filePath = $desktopPath + "\" + $file.Name;
        Move-Item -Path $filePath -Destination $fullImagePath;
    }
}