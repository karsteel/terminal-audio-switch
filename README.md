# terminal-audio-switch

Linux Bash scripts to change audio input and output in the terminal based on pactl. Compatible with Pipewire.

**Problem I wanted to solve:**

I have like 5 different audio devices connected to my PC. When I am in an online meeting where I need to wear a headset, I have to manually click around in sound settings to set up correct devices. This is annoying. I would like to be able to set the correct devices and settings for those with just one small terminal command to save time. At the same time it had to be compatible with [Pipewire](https://pipewire.org/) that I now run as default. So this made things harder.

**My solution:**

After quite some research I figured out how to switch speaker (sink), mic (source) and also change the audio profile of the connected device (like A2DP bluetooth codec) in Pipewire and built 3 scripts for each of my 3 personal use cases.

**What's in it for you?**

If you want to control your Pipewire devices through the terminal or a Bash script you should find my scripts helpful and avoid all the trial and error that I did :)

Values are hardcoded to my speakers in several cases. Here is an example:

`BLUEZ_DEVICE="$(grep bluez_output.30_50_75 <<< "$LIST_SPEAKERS")"`

So here the "bluez_output.30_50_75" is my Jabra headset.

You would have to run the command "pactl list short sinks" in your terminal to see the names of your own connected speakers for example and then replace those that are relevant in the code.

The main reason it is all hardcoded is that I wanted to control exactly which of my devices become default when i run some custom commands in my terminal.

The 3 bash files control 3 different scenarios.

And how do I use them?

In my case I set it up like this in my .bash_aliases file (which enables me to make terminal shortcuts):

`alias kmic='/home/$user/.kaudio/.kmic-audio.sh'`

`alias kq='/home/$user/.kaudio/.kq-audio.sh'`

`alias kl='/home/$user/.kaudio/.kl-audio.sh'`

So each of these 3 control different scenarios. 

typing "kl" in the terminal sets my speaker and webcam mic as default.

typing "kmic" in the terminal sets my Jabra headset as default and enables the correct audio profile for the headset mic

typing "kq" in the terminal sets my Jabra headset as default and enables quality sound profile (a2dp) which doesn't work with mic. Yeah bluetooth still kinda sucks ;D
