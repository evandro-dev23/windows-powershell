Get-ADUser -Filter * -Properties WhenCreated | Sort-Object WhenCreated -Descending | Select-Object Name, WhenCreated -First 10
#O número no final é a quantidade que vai trazer. Por exemplo, serão os últimos 10 usuários
