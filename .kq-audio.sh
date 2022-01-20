# First find Default output speaker (current one) and store in variable

CUR_DEFAULT_SPEAKER="$(pactl info | grep 'Default Sink' | cut -d':' -f 2)"

# And list all current speakers that are connected to the PC

LIST_SPEAKERS="$(pactl list short sinks | cut -d'	' -f 2)"

# This looks for any bluetooth devices in the list of speakers and returns that full speaker name (sink)

BLUEZ_DEVICE="$(grep bluez_output.30_50_75 <<< "$LIST_SPEAKERS")"


# kq: This is the logic to switch to headset quality sound:

# If current default speaker is the headset version of Jabra headset change audio profile to become HQ + switch to webcam mic

if
	[[ $CUR_DEFAULT_SPEAKER == *"22_A7.headset-head-unit"* ]]
	then pactl set-card-profile bluez_card.30_50_75_00_22_A7 a2dp-sink && pactl set-default-source alsa_input.usb-046d_Logitech_StreamCam_D109ED45-02.analog-stereo && systemctl --user daemon-reload
	echo "Switching to quality headset mode"


# If current default speaker is already the HQ version do nothing + switch to webcam mic

elif
	[[ $CUR_DEFAULT_SPEAKER == *"22_A7.a2dp-sink"* ]]
	then pactl set-default-source alsa_input.usb-046d_Logitech_StreamCam_D109ED45-02.analog-stereo && systemctl --user daemon-reload
	echo "Already on quality headset mode :)"

# If the 2 checks above failed we will now see if any bluetooth device is connected but just not the default speaker. Then make it default and set correct HQ audio profile + switch to webcam mic

elif
	[[ $LIST_SPEAKERS == *"bluez"* ]]
	then pactl set-default-sink $BLUEZ_DEVICE	&& pactl set-card-profile bluez_card.30_50_75_00_22_A7 a2dp-sink && pactl set-default-source alsa_input.usb-046d_Logitech_StreamCam_D109ED45-02.analog-stereo && systemctl --user daemon-reload
	echo "Changing speaker & switching to quality headset mode"

# Lastly if no bluetooth devices found then do nothing. Yes this step doesn't need a condition to check, but wuddahell ;)

elif
	[[ ! $LIST_SPEAKERS == *"bluez"* ]]
	then echo "Bluetooth headset not found :/"
fi
