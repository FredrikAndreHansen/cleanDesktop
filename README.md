A PowerShell script that automatically takes all files on the desktop/or any folders of your choice and sort them in a different folder by date and file type.

For example, if you have a .txt and a .jpg file on your desktop, then run the script, it will then place the .txt file in a new folder named "Documents" and place it in a subfolder named current month and year (April_2025 for example). The same will happen in the .jpg file, but it will go in a folder named "Images".
It will sort by images, videos, documents and all other files!

If the subfolder with the current month and year dont exist, it will also automatically be created!
Also, if the filename is duplicate, it will then get a new name (a number will be added to the name).

Configuration
This is the current path to clean
<# Desktop path #>
[string]$desktopPath = "C:\Users\Fredrik\Desktop";

All destination paths, the folder named "Files" must contain the following subfolders "Images", "Documents", "Videos" and "Other".
<# Destination paths #>
[string]$customDesktopPath = "C:\Users\Fredrik\CustomDesktop\Files";
[string]$imagesFolder = "\Images";
[string]$documentsFolder = "\Documents";
[string]$videosFolder = "\Videos";
[string]$otherFolder = "\Other";
