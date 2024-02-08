# Overwrites the terraform-docs section in the README.md file with the latest output from terraform-docs.

# Temporary file paths
$beforeDocs = New-TemporaryFile
$afterDocs = New-TemporaryFile
$newDocs = New-TemporaryFile

# Extract content before the terraform-docs section
(Get-Content README.md -Raw) -split '(<!-- BEGIN_TF_DOCS -->)' | Select-Object -First 1 | Set-Content -Path $beforeDocs

# Extract content after the terraform-docs section
(Get-Content README.md -Raw) -split '(<!-- END_TF_DOCS -->)' | Select-Object -Last 1 | Set-Content -Path $afterDocs

# Generate new terraform-docs content
terraform-docs markdown . | Out-File -FilePath $newDocs

# Combine the parts
Get-Content -Path $beforeDocs | Set-Content -Path README.md
Add-Content -Value "<!-- BEGIN_TF_DOCS -->" -Path README.md
Get-Content -Path $newDocs | Add-Content -Path README.md
Add-Content -Value "<!-- END_TF_DOCS -->" -Path README.md
Get-Content -Path $afterDocs | Add-Content -Path README.md

# Clean up
Remove-Item -Path $beforeDocs, $afterDocs, $newDocs
