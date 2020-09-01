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

:if ($params="show") do={
	:local output "Router ID:* $[/system identity get name] * %0A%0A"
	:local eth01status
	:local eth03status
	:local eth04status
	:local eth05status

	:if ([/interface ethernet get eth01-router running]=true) do={
		:set eth01status ("Internet is *CONNECTED*%0A")
	} else={
		:set eth01status ("Internet is *DISCONNECTED*%0A")
	}

	:if ([/interface ethernet get eth03-lantai-1 running]=true) do={
		:set eth03status ("Lantai 1 is *CONNECTED*%0A")
	} else={
		:set eth03status ("Lantai 1 is *DISCONNECTED*%0A")
	}

	:if ([/interface ethernet get eth04-lantai-2 running]=true) do={
		:set eth04status ("Lantai 2 is *CONNECTED*%0A")
	} else={
		:set eth04status ("Lantai 2 is *DISCONNECTED*%0A")
	}

	:if ([/interface ethernet get eth05-configurator running]=true) do={
		:set eth05status ("Config is *CONNECTED*%0A")
	} else={
		:set eth05status ("Config is *DISCONNECTED*%0A")
	}
	:set output ($output.$eth01status.$eth03status.$eth04status.$eth05status)
	$send chat=$chatid text=("$output") mode="Markdown"
}