#!/usr/bin/env pwsh

# [CmdletBinding(PositionalBinding = $false)]
param(
    [string] $searchstr = 'nocommit',
    [Parameter(Position=0, ValueFromRemainingArguments = $true)][string[]] $remaining_files
)

[string[]] $diff_files = git diff --staged -i --diff-filter=d --name-only -G "$searchstr" $remaining_files;

if ($diff_files.count -gt 0) {
    Write-Host "Error: commit gate phrase '$searchstr' was found in $($diff_files.count) file(s):" -ForegroundColor Red;
    Write-Host "$($diff_files | Out-String)" -ForegroundColor Red -NoNewline;
    exit 1;
}

exit 0;