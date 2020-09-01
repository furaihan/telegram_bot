:local send [:parse [/system script get tg_sendMessage source]]
:local param1 [:pick $params 0 [:find $params " "]]
:local param2 [:pick $params ([:find $params " "]+1) [:len $params]]
:local param3 [:pick [:pick $params ([:find $params " "]+1) [:len $params]] ([:find [:pick $params ([:find $params " "]+1) [:len $params]] " "]+1) [:len [:pick $params ([:find $params " "]+1) [:len $params]]]]
:if ([:len [:find $param2 " "]]>0) do={
	:set param2 [:pick [:pick $params ([:find $params " "]+1) [:len $params]] 0 [:find [:pick $params ([:find $params " "]+1) [:len $params]] " "]]
} else={
	:set param3 ""
}

:put $params
:put $param1
:put $param2
:put $param3
:put $chatid
:put $from

:if ($param1="delete") do={
/ppp secret remove [find name=$param2]
$send chat=$chatid text=("User PPP: $param2 Berhasil dihapus") mode="Markdown"
}
:if ($param1="disable") do={
/ppp secret disable [find name=$param2]
$send chat=$chatid text=("User PPP: $param2 Disable") mode="Markdown"
}
:if ($param1="enable") do={
/ppp secret enable [find name=$param2]
$send chat=$chatid text=("User PPP: $param2 Enable") mode="Markdown"
}
:if ($param1="password") do={
/ppp secret set password=$param3 [find name=$param2]
/ppp active remove [find name=$param2]
$send chat=$chatid text=("User PPP: $param2 pasword diganti menjadi $param3...") mode="Markdown"
}
:if ($param1="profile") do={
/ppp secret set profile=$param3 [find name=$param2]
/ppp active remove [find name=$param2]
$send chat=$chatid text=("User PPP: $param2 profile diganti menjadi $param3...") mode="Markdown"
}
:if ($params="print") do={
:local output
:foreach activeIndex in=[/ppp active find] do={
:local activeUser ("*Username:* ".[/ppp active get value-name="name" $activeIndex]."%0A")
:local activeAddress ("*Address:* ".[/ppp active get value-name="address" $activeIndex]."%0A")
:local activeCaller ("*Caller-ID:* ".[/ppp active get value-name="caller-id" $activeIndex]."%0A")
:local activeUptime ("*Uptime:* ".[/ppp active get value-name="uptime" $activeIndex]."%0A")
:local activeService ("*Service:* ".[/ppp active get value-name="service" $activeIndex]."%0A")
:set output ($output.$activeUser.$activeAddress.$activeCaller.$activeUptime.$ActiveService."%0A")
}
$send chat=$chatid text=("$output") mode="Markdown"
}
:if ($param1!="password" and $param1!="profile" and $param1!="enable" and $param1!="disable" and $param1!="delete" and $param1!="print") do={
/ppp secret add name=$param1 password=$param2 service=pptp profile=$param3 
$send chat=$chatid text=("User PPP %0AUsername: $param1 %0APassword: $param2 %0AProfile: $param3 %0ABerhasil dibuat...") mode="Markdown"
}