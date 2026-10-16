playerctl -p "$(playerctl -l | wmenu -l 5)" "$(printf 'play-pause\nplay\npause\nnext\nprevious'|wmenu)" 
