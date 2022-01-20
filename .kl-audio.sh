# First find Default output speaker (current one) and store in variable

CUR_DEFAULT_SPEAKER="$(pactl info | grep 'Default Sink' | cut -d':' -f 2)"

# And list all current speakers that are connected to the PC

LIST_SPEAKERS="$(pactl list short sinks | cut -d'	' -f 2)"


# kl: This is the logic to switch to da real speakers

# If current default speaker is a Jabra headset change audio profile to become KL + switch to webcam mic

if
	[[ $CUR_DEFAULT_SPEAKER == *"bluez"* ]]
	then pactl set-default-sink alsa_output.pci-0000_2b_00.4.analog-stereo.monitor && pactl set-default-source alsa_input.usb-046d_Logitech_StreamCam_D109ED45-02.analog-stereo && systemctl --user daemon-reload
	echo "Switching to da real speakers"


# If current default speaker is already the KL version do nothing + switch to webcam mic

elif
	[[ $CUR_DEFAULT_SPEAKER == *"00.4.analog-stereo"* ]]
	then pactl set-default-source alsa_input.usb-046d_Logitech_StreamCam_D109ED45-02.analog-stereo && systemctl --user daemon-reload
	echo "Already on da real speakers :)"


# Lastly if speakers disappeared

elif
	[[ ! $LIST_SPEAKERS == *"00.4.analog-stereo"* ]]
	then echo "Speakers disappeared eeehhhm :/"
fi
