#---------- Declarations / configurations
# Watch folder for incoming CSV files, processed folder for moving validated files, and log file for recording validation errors
$watchFolder = "C:\Logs\MineData"
$processedFolder = "$watchFolder\processed"
$logFile = "$watchFolder\Validation_Errors.log"
#---------- End of declarations

# Create log file if it doesn't exist
if (!(Test-Path $logFile)) {
    New-Item -Path $logFile -ItemType File
}

#Create processed folder if it doesn't exist
if (!(Test-Path $processedFolder)) {
    New-Item -Path $processedFolder -ItemType Directory
}

#------- Functions
function write-log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $timestampedMessage = "$timestamp - $message"
    Add-Content -Path $logFile -Value $timestampedMessage
    Write-Host $timestampedMessage
}

Write-Host "Starting CSV validation..."

try {

    # Get all CSV files
    $csvFiles = Get-ChildItem -Path $watchFolder -Filter *.csv

    foreach ($file in $csvFiles) {

        Write-Host "Checking file: $($file.Name)"

        # Import CSV
        $data = Import-Csv $file.FullName

        # Validate that the 'Tonnes' column exists and is not empty
        if(-not ($row.tonnes)) {
            $errorMessage = "$(Get-Date) - ERROR in $($file.Name): Tonnes column is missing or empty."
            write-log -message $errorMessage
            continue
        }

        foreach ($row in $data) {


            # Convert tonnes to number
            $tonnes = [int]$row.Tonnes

            # Validation rule
            if ($tonnes -lt 0) {

                $errorMessage = "$(Get-Date) - ERROR in $($file.Name): Negative tonnes value found ($tonnes)"

                # Write to log
                write-log -message $errorMessage
            }
        }
        Move-Item $file.FullName "$processedFolder\"
    }

    Write-Host "Email would be sent if there were any validation errors. Check the log file for details."

}
catch {

    $crashMessage = "$(Get-Date) - SCRIPT FAILURE: $_"

    write-log -message $crashMessage
}