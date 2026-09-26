#!/bin/bash

blackl="6B6B6B"
blackd="181818"
redl="C55555"
redd="AC4242"
greenl="AAC474"
greend="90A959"
yellowd="FECA88"
yellowd="D79921"
bluel="82B8C8"
blued="6A9FB5"
magental="C28CB8"
magentad="AA759F"
bbd="75B5AA"
bbl="93D3C3"
whitel="F8F8F8"
whited="EEEEEE"

while true;
do
#if [ "$(darkman get)" = "light" ];then
#    background="whited"
#else
#    background="blackd"

# Date and Time
tnd="$(date "+%a %m/%d %H:%M")"

# Volume
volraw="$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 { print $5 }' |sed 's/%//')"

if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk 'NR==1 { print $2 }')" = "yes" ]; then
    vol="^fg($redl)MUTED^fg()"
elif [ "$volraw" = 0 ]; then
    vol="^fg($redl).....^fg()"
elif (( volraw <= 20 )); then
    vol="^fg($greenl)|....^fg()"
elif (( volraw <= 40 )); then
    vol="^fg($greenl)||...^fg()"
elif (( volraw <= 60 )); then
    vol="^fg($yellowd)|||..^fg()"
elif (( volraw <= 80 )); then
    vol="^fg($yellowd)||||.^fg()"
elif (( volraw >= 100 )); then
    vol="^fg($redl)|||||^fg()"
else
    vol="off"
fi
# Battery
# Perc
bat="$(< /sys/class/power_supply/BAT0/capacity)"

if (( bat <= 10 )); then
    batcol="^fg($redl)^fg()"
elif (( bat <= 20 )); then
    batcol="^fg()^fg($redl)"
elif (( bat <= 65 )); then
    batcol="^fg()^fg($yellowd)"
else
  batcol="^fg()^fg($greenl)"
fi

if (( "$bat" >= 100 )); then
    bat="󰁹"
elif (( "$bat" >= 90 )); then
    bat="󰂂"
elif (( "$bat" >= 80 )); then
    bat="󰂁"
elif (( "$bat" >= 70 )); then
    bat="󰂀"
elif (( "$bat" >= 60 )); then
    bat="󰁿"
elif (( "$bat" >= 50 )); then
    bat="󰁾"
elif (( "$bat" >= 40 )); then
    bat="󰁽"
elif (( "$bat" >= 30 )); then
    bat="󰁼"
elif (( "$bat" >= 20 )); then
    bat="󰁻"
elif (( "$bat" >= 10 )); then
    bat="󰁺"
fi

# Stat
batstf="$(cat /sys/class/power_supply/BAT0/status)"
if [ "$batstf" = "Full" ]; then
   batst=""
elif [ "$batstf" = "Discharging" ]; then
   batst=""
else
   batst="󱐋"
fi

# Wireless
# Bluetooth
btraw="$(bluetoothctl info | awk 'NR==10 {print $2}')"
btlogo=" 󰂯"
if [ "$btraw" = "yes" ]; then
   bt="$(bluetoothctl info | awk 'NR==3 {print }' | sed 's/.*Alias: //') "
else
    #bt="^fg()off^fg()"
    bt=" "
    btlogo=""
fi

btbat="$(bluetoothctl info | tail -n1 | awk '{ print $4 }'| sed 's/(//' | sed 's/)//') "

if [ "$btbat" = "argument " ]; then
    btbat=" "
else
    if (( "$btbat" <= 20 )); then
        btbat="󰁻 "
    elif (( "$btbat" <= 30 )); then
        btbat="󰁼 "
    elif (( "$btbat" <= 40 )); then
        btbat="󰁽 "
    elif (( "$btbat" <= 50 )); then
        btbat="󰁾 "
    elif (( "$btbat" <= 60 )); then
        btbat="󰁿 "
    elif (( "$btbat" <= 70 )); then
        btbat="󰂀 "
    elif (( "$btbat" <= 80 )); then
        btbat="󰂁 "
    elif (( "$btbat" <= 90 )); then
        btbat="󰂂 "
    elif [ "$btbat" = "100" ]; then
        btbat="󰁹 "
    else
        btbat=""
    fi
fi

# Wi-Fi
wfname="$(nmcli connection show --active | awk 'NR==2 {print $1}')"
if [ "$wfname" = "lo" ]; then
    wfname="off"
    wfsig=""
else
    wfsig="$(nmcli -f IN-USE,SIGNAL device wifi | grep '*' | awk '{print $2}')"
    if (( "$wfsig" <= 20 )); then
        wfsig="󰤯"
    elif (( "$wfsig" <= 40 )); then
        wfsig="󰤟"
    elif (( "$wfsig" <= 60 )); then
        wfsig="󰤢"
    elif (( "$wfsig" <= 80 )); then
        wfsig="󰤥"
    elif (( "$wfsig" <= 100 )); then
        wfsig="󰤨"
    fi
fi

# Weather
wtr="$(cat $HOME/.local/share/wtr | head -n1)"
wtrtemp=$(echo $wtr | awk '{print $1 }' | awk '{printf("%d\n",$1 + 0.5)}')
wtrpre=$(echo $wtr | awk '{print $2 }' | awk '{printf("%d\n",$1 + 0.5)}' )
wtrcc=$(echo $wtr | awk '{print $3 }'|head -n1)

if (( "$wtrtemp" <= 20 )); then
    wtrcol="$bbl"
elif (( "$wtrtemp" <= 36 )); then
    wtrcol="$yellowd"
else
    wtrcol="$redl"
fi

if (( "$wtrpre" >= 3 )); then
    if (( "$wtrcc" >=20 ));then
        wtri="󰼳 "
    else
        wtri="󰖗 "
    fi
else
    if (( "$wtrcc" <= 20 )); then
        wtri="󰖙 "
    elif (( "$wtrcc" <= 50 )); then
        wtri=" "
    elif (( "$wtrcc" <= 70 )); then
        wtri=" "
    else
        wtri="󰖐 "
    fi
fi
if [ "$wtr" = "" ] ; then
    wtrtemp="n/a"
    wtrpre="n/a"
    wtrcc="n/a"
    wtri=""
    wtrcol="FFFFFF"
fi
if [ "$wtr" = "null null null" ] ; then
    wtrtemp="n/a"
    wtrpre="n/a"
    wtrcc="n/a"
    wtri=""
    wtrcol="FFFFFF"
fi

# UP AND DN
# Converts bytes (integer) to human-readable (base-1024)
bytes_h() {
  local b="$1"
  local units=(" b" Kb Mb Gb Tb)
  local i=0

  # handle 0
  if (( b <= 0 )); then echo "000  b"; return; fi

  while (( b >= 1024 && i < ${#units[@]}-1 )); do
    b=$(( b / 1024 ))
    ((i++))
  done

  # pad only when it's 1-2 digits (less than 3 digits)
  if (( b < 100 )); then
    printf "%03d %s\n" "$b" "${units[i]}"
  else
    printf "%d %s\n" "$b" "${units[i]}"
  fi
}

STATEFILE="${STATEFILE:-/tmp/netdev_widget.prev}"
touch "$STATEFILE"

# default interface
default_if="$(awk '($2 ~ /^[0-9A-Fa-f]+$/) && $2=="00000000"{print $1; exit}' /proc/net/route 2>/dev/null || true)"
if [[ -z "$default_if" ]]; then
  default_if="$(awk 'NR>2 {gsub(":","",$1); if($1!="lo"){print $1; exit}}' /proc/net/dev 2>/dev/null || true)"
fi

declare -A prev_rx prev_tx
if [[ -s "$STATEFILE" ]]; then
  while read -r ifname rx tx; do
    [[ -n "$ifname" ]] || continue
    prev_rx["$ifname"]="$rx"
    prev_tx["$ifname"]="$tx"
  done < "$STATEFILE"
fi

tmp="$(mktemp)"
awk 'NR>2 { gsub(":","",$1); ifname=$1; rx_bytes=$2; tx_bytes=$10; print ifname, rx_bytes, tx_bytes }' /proc/net/dev > "$tmp"
mv -f "$tmp" "$STATEFILE"

if [[ -n "$default_if" ]]; then
  read -r _ rx_now tx_now < <(awk -v ifn="$default_if" '$1==ifn{print $1,$2,$3}' "$STATEFILE")
  prx="${prev_rx[$default_if]:-0}"
  ptx="${prev_tx[$default_if]:-0}"

  dn_bytes=$((rx_now - prx)); (( dn_bytes < 0 )) && dn_bytes=0   # download (RX) delta bytes
  up_bytes=$((tx_now - ptx)); (( up_bytes < 0 )) && up_bytes=0   # upload (TX) delta bytes

  dn="$(bytes_h "$dn_bytes")"
  up="$(bytes_h "$up_bytes")"
else
  dn="000  b"
  up="000  b"
fi

# now use: $up and $dn
#cput=$(cat /sys/class/thermal/thermal_zone2/temp| sed 's/...$//')
#if (( "$cput" >= 30 )); then
#    cput="$greenl"
#elif (( "$cput" >= 60 )); then
#    cput="$redl"
#else
#    cput="$yellowd"
#fi
cpup="$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'| sed 's/\..*//')"

cpup="$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'|sed 's/\..*//')"
if (( "$cpup" <= 12 )); then
    cpup="▁"
elif (( "$cpup" <= 24 )); then
    cpup="▂"
elif (( "$cpup" <= 36 )); then
    cpup="▃"
elif (( "$cpup" <= 48 )); then
    cpup="▄"
elif (( "$cpup" <= 60 )); then
    cpup="▅"
elif (( "$cpup" <= 72 )); then
    cpup="▅"
elif (( "$cpup" <= 84 )); then
    cpup="▆"
elif (( "$cpup" <= 96 )); then
    cpup="▇"
else
    cpup="█"
fi

memp="$(free | awk '/Mem:/ {printf "%.0f", ($2-$7)/$2*100}')"
if (( "$memp" <= 12 )); then
    memp="▂"
elif (( "$memp" <= 36 )); then
    memp="▃"
elif (( "$memp" <= 48 )); then
    memp="▄"
elif (( "$memp" <= 60 )); then
    memp="▅"
elif (( "$memp" <= 72 )); then
    memp="▅"
elif (( "$memp" <= 84 )); then
    memp="▆"
elif (( "$memp" <= 96 )); then
    memp="▇"
else
    memp="█"
fi
diskp="$(df -h | head  -n5 | tail -n1 | awk '{print $5}' | sed 's/\%//')"
if (( "$diskp" <= 12 )); then
    diskp="▂"
elif (( "$diskp" <= 36 )); then
    diskp="▃"
elif (( "$diskp" <= 48 )); then
    diskp="▄"
elif (( "$diskp" <= 60 )); then
    diskp="▅"
elif (( "$diskp" <= 72 )); then
    diskp="▅"
elif (( "$diskp" <= 84 )); then
    diskp="▆"
elif (( "$diskp" <= 96 )); then
    diskp="▇"
else
    diskp="█"
fi

if [ "$(darkman get)" = "dark" ]; then
    dorl=""
else
    dorl=""
fi

# Seeds
#seeds=$(expr $(transmission-remote -l | wc -l) - 2)
#seeds="  $(transmission-remote -l -a | grep 'Down' | awk "{ print $2 }" | head -n2 | tail -n1 | sed 's/...$//') "
#if [ $seeds = "-2" ];then
    seeds=""
#fi
#
#echo " ^fg($bbl)󰋊$diskp ^fg()^fg($magental)$memp^fg() ^fg($bluel)$cpup^fg() ^fg($wtrcol)$wtri$wtrtemp°C^fg() ^fg($greenl) $seeds^fg() ^fg($bbl)🡩$up/s^fg() ^fg($magental)🡫$dn/s^fg() ^fg($greenl)$wfsig $wfname^fg() ^fg($bluel)󰂯$btbat$bt^fg() $vol $batcol$batst$bat^fg()^fg() $tnd "
#echo " ^fg($bluel)$cpup^fg() ^fg($wtrcol)$wtri$wtrtemp°C^fg() ^fg($greenl) $seeds^fg() ^fg($bbl)🡩$up/s^fg() ^fg($magental)🡫$dn/s^fg() ^fg($greenl)$wfsig $wfname^fg()^fg($bluel)$btlogo$btbat$bt^fg() $vol $batcol$batst$bat^fg()^fg() $tnd "
#echo "^bg($background) ^fg($bluel)$cpup^fg() ^fg($wtrcol)$wtri$wtrtemp°C^fg() ^fg($bbl)🡩$up/s^fg() ^fg($magental)🡫$dn/s^fg() ^fg($greenl)$wfsig $wfname^fg()^fg($bluel)$btlogo$btbat$bt^fg() $vol $batcol$batst$bat^fg()^fg() $tnd ^bg()"
#echo " ^fg($bluel)$cpup^fg() ^fg($wtrcol)$wtri$wtrtemp°C^fg() ^fg($bbl)🡩$up/s^fg() ^fg($magental)🡫$dn/s^fg() ^fg($greenl)$wfsig $wfname^fg()^fg($bluel)$btlogo$btbat$bt^fg() $vol $batcol$batst$bat^fg()^fg() $tnd "
echo " ^fg($yellowd)$memp^fg() ^fg($bluel)$cpup^fg()^fg($greenl) $seeds^fg()^fg($wtrcol)$wtri$wtrtemp°C^fg() ^fg($magental)🡫$dn/s^fg() ^fg($greenl)$wfsig $wfname^fg()^fg($bluel)$btlogo$btbat$bt^fg()$vol $batcol$batst$bat^fg()^fg() $dorl $tnd "
#echo " $cpup$seeds $wtri$wtrtemp°C 🡫$dn/s $wfsig $wfname $btlogo$btbat$bt $volraw $batst$bat $dorl $tnd "
sleep 0.2
done
