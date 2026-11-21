Import-Module ActiveDirectory

# Data atual
$dataAtual = Get-Date

# Caminho onde o arquivo CSV salvo (Na linha abaixo é só um exemplo)
$caminhoCSV = "C:\Users\evandro\Documentos\Consultas_AD\Usuarios_Senha_Expirada_.csv"

# Busca por usuários no AD (Active Directory)
$usuarios = Get-ADUser -Filter {
    Enabled -eq $true -and
    PasswordNeverExpires -eq $false
} -Properties DisplayName, mail, employeeID, title, department, msDS-UserPasswordExpiryTimeComputed |
Where-Object {
    $_."msDS-UserPasswordExpiryTimeComputed" -ne $null
} |
Select-Object `
    Name,
    SamAccountName,
    mail,
    employeeID,
    title,
    department,
    @{Name="DataExpiracaoSenha"; Expression={
        [datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")
    }} |
Where-Object {
    $_.DataExpiracaoSenha -lt $dataAtual
}

# Exportando para CSV
$usuarios | Export-Csv -Path $caminhoCSV -NoTypeInformation -Encoding UTF8

# Imprimindo na tela
Write-Host "Arquivo CSV criado com sucesso ;)" -ForegroundColor Green
