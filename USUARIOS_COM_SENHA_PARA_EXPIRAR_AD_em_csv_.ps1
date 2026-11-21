Import-Module ActiveDirectory

# Define a data atual e o intervalo de expiração. Vc pode alterar o número (30) por (15), por exemplo.
$dataAtual = Get-Date
$dataLimite = $dataAtual.AddDays(30)

# Caminho para salvar o arquivo CSV na pasta documentos do usuário atual
$caminhoCSV = "$env:USERPROFILE\Documentos\Consultas_AD\Usuarios_Senha_Expirando_.csv"

# Coleta usuários do AD
$usuarios = Get-ADUser -Filter {
    Enabled -eq $true -and
    PasswordNeverExpires -eq $false
} -Properties DisplayName, mail, msDS-UserPasswordExpiryTimeComputed |
Where-Object {
    $_."msDS-UserPasswordExpiryTimeComputed" -ne $null
} |
Select-Object `
    Name,
    SamAccountName,
    DisplayName,
    mail,
    @{Name="DataExpiracaoSenha"; Expression={
        [datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")
    }} |
Where-Object {
    $_.DataExpiracaoSenha -le $dataLimite -and
    $_.DataExpiracaoSenha -ge $dataAtual
}

# Exporta para CSV
$usuarios | Export-Csv -Path $caminhoCSV -NoTypeInformation -Encoding UTF8

# Imprimindo na tela
Write-Host "Arquivo CSV gerado com sucesso ;)" -ForegroundColor Green

