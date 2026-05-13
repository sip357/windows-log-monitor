# Windows Log Monitor & Report Tool
Overview

The Windows Log Monitor & Report Tool is a lightweight PowerShell automation project that monitors a Windows folder for incoming CSV files, validates operational data, logs errors, and simulates automated reporting.

Validation Rule: The script validates the Tonnes column in each CSV file.

Example Rule: Tonnes value must not be negative

This project demonstrates:
PowerShell scripting
Logging and error handling
Maintainability and sustainment practices

The tool is designed to simulate a simple operational monitoring workflow similar to environments where automated validation and reporting are required.

# Technologies Used
PowerShell
CSV Processing
File System Operations
Logging and Error Handling

# Run the Script

Open PowerShell:

`cd path\to\project`

Run:

`.\monitor.ps1`

If PowerShell blocks execution:

`Set-ExecutionPolicy -Scope Process Bypass`

# Structure
windows-log-monitor/
│
├── monitor.ps1
├── sample_data/
│   ├── valid_file.csv
│   └── invalid_file.csv
│
├── logs/
│   └── validation_errors.log
│
├── processed/
│
└── README.md