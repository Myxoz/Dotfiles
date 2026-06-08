function transcribe -d "Transcribes audio from the microphone to text locally"
    set -l audio ~/.cache/transcribe.wav
    set -l model ~/.config/whisper-models/ggml-large-v3-turbo.bin

	arecord -f S16_LE -r 16000 -c 1 $audio >/dev/null 2>&1 &
	set -l pid $last_pid

	tput civis
	set -l frames "•" "●" "•" " "
	set -l i 1
	set SECONDS 0

	stty -icanon -echo min 0 time 0

	while true
		set -l mins (math -s0 "$SECONDS / 60")
		set -l secs (math -s0 "$SECONDS % 60")

		# Format them with leading zeros (mm:ss)
		set -l time_str (printf "%02d:%02d" $mins $secs)
		printf "\r\r\033[31m %s Recording [%s] \033[0m " $frames[$i] $time_str

		set i (math "$i % 4 + 1")

		set -l key (dd bs=1 count=1 2>/dev/null </dev/tty)

		if test "$key" = q
			break
		end
		set SECONDS (math "$SECONDS + 0.15")
		sleep 0.15
	end

	stty sane
	tput cnorm
	printf "\n"

    kill $pid
    wait $pid 2>/dev/null

	set -l tmp (mktemp)

	whisper-cli -m $model -f $audio -t 6 --no-timestamps -nt 2>/dev/null | string trim | tee $tmp

	set -l text (cat $tmp | string trim)
	rm $tmp
	echo
	echo
	read -n 1 -P "Copy? [y/n] " answer

	if test "$answer" = y
		echo $text | wl-copy
		echo
		echo "Copied."
	end
end
