media=$(playerctl metadata -f "{{ '{{artist}}' }}"| cut -f1)
player_status=$(playerctl status)

escape_html() {
    echo "$1" | sed -E 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g'
}
media=$(escape_html "$media")
if [[ $player_status = "Playing" ]]
then
    song_status=' '
else
    song_status=' '
fi

printf '%s %s\n' "$song_status $media"
