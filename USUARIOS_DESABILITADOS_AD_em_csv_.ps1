Get-ADUser -Filter {Enabled -eq $false} `
  -Properties Name, mail, SamAccountName, whenChanged |
  Select-Object `
    Name,
    mail,
    SamAccountName,
    @{Name="DataDesabilitacao";Expression={$_.whenChanged}} |
  
  # Exporta para CSV
  Export-Csv "C:\Users\evandro\Documentos\Consultas_AD\Usuarios_Desabilitados_AD_.csv" -NoTypeInformation -Encoding UTF8
  
# Imprimindo na tela
  Write-Host "Arquivo CSV gerado com sucesso ;)" -ForegroundColor Green

