$group = Read-Host 'Group Name'
(([adsisearcher]"memberOf:1.2.840.113556.1.4.1941:=$(([adsisearcher]"name=$group").Findone().Path.Substring(7))").findall() `
 | ? {$_.Properties.objectclass -contains "user"}).Properties.cn

$group = Read-Host 'Group Name'
$root = "LDAP://$(([adsi]"LDAP://rootdse").defaultNamingContext)"
$searchergroup =[adsisearcher]"name=$group"
$searchergroup.SearchRoot = $root
$searcheruser = [adsisearcher]"memberOf:1.2.840.113556.1.4.1941:=$($searchergroup.Findone().Path.Substring(7))"
$searcheruser.SearchRoot = $root
$searcheruser.FindAll() |  ? {$_.Properties.objectclass -contains "user"} | % {write-host $_.Properties.cn}
