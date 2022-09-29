#!powershell.exe

$searchstr = 'nocommit';
$diff = git diff --staged -i --diff-filter=d --name-only -G "$searchstr" --relative $(pwd);
$numfiles = ($diff | Measure-Object -Line).Lines;

if ($numfiles -gt 0) {
    Write-Host "Error: string $searchstr was found in $numfiles file(s):" -ForegroundColor Red;
    Write-Host "$($diff | Out-String)" -ForegroundColor Red -NoNewline;
    exit 1;
}
