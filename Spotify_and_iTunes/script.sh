DATA=$(osascript -e '
tell application "System Events"
    set myList to (name of every process)
end tell

set output to ""

set i_track to ""
set i_artist to ""
set i_album to ""
set i_state to ""

set s_track to ""
set s_artist to ""
set s_album to ""
set s_state to ""

if myList contains "iTunes" then
    tell application "iTunes"
        if player state is stopped then
            set i_state to "stop"
        else
            set i_track to name of current track
            set i_artist to artist of current track
            set i_album to album of current track
            if player state is playing then
                set i_state to "play"
            else if player state is paused then
                set i_state to "pause"
            end if
        end if
    end tell
end if
if myList contains "Spotify" then
    tell application "Spotify"
        if player state is stopped then
            set s_state to "stop"
        else
            set s_track to name of current track
            set s_artist to artist of current track
            set s_album to album of current track
            if player state is playing then
                set s_state to "play"
            else if player state is paused then
                set s_state to "pause"
            end if
        end if
    end tell
else
    set output to ""
end if

    if s_state = "play" then
        if i_state = "play" then
            set output to "iTunes: " & i_track & " by " & i_artist & " (" & i_album & ") " & "Spotify: " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "pause" then
            set output to "iTunes: Paused. " & i_track & " by " & i_artist & " (" & i_album & ") " & "Spotify: " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "stop" then
            set output to "Spotify: " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "" then
            set output to "Spotify: " & s_track & " by " & s_artist & " (" & s_album & ")"
        end if
    else if s_state = "pause" then
        if i_state = "play" then
            set output to "iTunes: " & i_track & " by " & i_artist & " (" & i_album & ") " & "Spotify: Paused. " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "pause" then
            set output to "iTunes: Paused. " & i_track & " by " & i_artist & " (" & i_album & ") " & "Spotify: Paused. " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "stop" then
            set output to "Spotify: Paused. " & s_track & " by " & s_artist & " (" & s_album & ")"
        else if i_state = "" then
            set output to "Spotify: Paused. " & s_track & " by " & s_artist & " (" & s_album & ")"
        end if
    else if s_state = "stop" or s_state = "" then
        if i_state = "play" then
            set output to "iTunes: " & i_track & " by " & i_artist & " (" & i_album & ")"
        else if i_state = "pause" then
            set output to "iTunes: Paused. " & i_track & " by " & i_artist & " (" & i_album & ")"
        else if i_state = "stop" or i_state = "" then
            set output to ""
        end if
    end if
')


echo $DATA | awk -F new_line '{print $1}'