﻿Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*"} | Sort-Object