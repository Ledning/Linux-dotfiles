#!/usr/bin/env bash

konsole -e "bash -ic \" ~/Scripts/gaptoggle.sh on\""
konsole -e "bash -ic \"i3-msg split h\""
i3-msg split h
i3-msg split h
i3-msg split h
sleep 1
konsole -e "bash -ic \"i3-msg split h && cat ~/Scripts/StartupRice/tutorial; bash\"" &
i3-msg split v
i3-msg split v
i3-msg split v
sleep 1
konsole -e "bash -ic \"i3-msg split v && clear && screenfetch; bash \"" &
konsole -e "bash -ic \"i3-msg split v\""
i3-msg split v
i3-msg split v
i3-msg split v
sleep 1
konsole -e "htop"
