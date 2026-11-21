Get-ADUser -Identity "nome.usuario" -Properties WhenCreated | Select-Object Name, WhenCreated
# Coloque o nome do usuário de rede entre as aspas, da mesma forma do exemplo.
