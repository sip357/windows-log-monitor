# Folder to monitor
$watchFolder = "C:\Logs\MineData"

# Log file
$logFile = "C:\Logs\MineData\validation_errors.log"

# Create log file if it doesn't exist
if (!(Test-Path $logFile)) {
    New-Item -Path $logFile -ItemType File
}

Write-Host "Starting CSV validation..."

try {

    # Get all CSV files
    $csvFiles = Get-ChildItem -Path $watchFolder -Filter *.csv

    foreach ($file in $csvFiles) {

        Write-Host "Checking file: $($file.Name)"

        # Import CSV
        $data = Import-Csv $file.FullName

        foreach ($row in $data) {

            # Convert tonnes to number
            $tonnes = [int]$row.Tonnes

            # Validation rule
            if ($tonnes -lt 0) {

                $errorMessage = "$(Get-Date) - ERROR in $($file.Name): Negative tonnes value found ($tonnes)"

                # Write to log
                Add-Content -Path $logFile -Value $errorMessage

                Write-Host $errorMessage
            }
        }
    }

    Write-Host "Email would be sent if there were any validation errors. Check the log file for details."

}
catch {

    $crashMessage = "$(Get-Date) - SCRIPT FAILURE: $_"

    Add-Content -Path $logFile -Value $crashMessage

    Write-Host $crashMessage
}