#!/bin/bash
# Plain-tmux session script (one window per section below; panes are split and
# their commands typed via send-keys). Edit the send-keys lines to change what
# runs in each pane; ./kill.sh stops everything.

SESSION_NAME=simulation

# absolute path to this script's directory; every pane starts here
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# commands executed first in every pane
PRE_WINDOW='export UAV_NAME=uav1;'
SETUP="cd $SCRIPTPATH; $PRE_WINDOW"

if [ -n "$TMUX" ]; then
  echo "Already inside tmux, detach first."
  exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session $SESSION_NAME already exists; attach with 'tmux a -t $SESSION_NAME' or stop it with ./kill.sh."
  exit 1
fi

# ---------------- window: roscore ----------------
read W_roscore P <<< "$(tmux new-session -d -s "$SESSION_NAME" -n "roscore" -x 250 -y 50 -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'roscore' Enter
tmux select-layout -t "$W_roscore" tiled

# ---------------- window: rviz ----------------
read W_rviz P <<< "$(tmux new-window -t "$SESSION_NAME" -n "rviz" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; rviz -d $(rospack find pairs_serial)/rviz/gimbal.rviz' Enter
P=$(tmux split-window -t "$W_rviz" -P -F '#{pane_id}')
tmux select-layout -t "$W_rviz" tiled
tmux send-keys -t "$P" "$SETUP; "'waitForRos; rosrun rqt_gui rqt_gui' Enter
tmux select-layout -t "$W_rviz" tiled

# ---------------- window: gimbal ----------------
read W_gimbal P <<< "$(tmux new-window -t "$SESSION_NAME" -n "gimbal" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; roslaunch pairs_serial gimbal.launch' Enter
tmux select-layout -t "$W_gimbal" tiled

# ---------------- window: jugger ----------------
read W_jugger P <<< "$(tmux new-window -t "$SESSION_NAME" -n "jugger" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; rosrun plotjuggler plotjuggler' Enter
tmux select-layout -t "$W_jugger" tiled

# ---------------- window: kill (press enter inside to stop the session) ----------------
read W_kill P <<< "$(tmux new-window -t "$SESSION_NAME" -n "kill" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SCRIPTPATH/kill.sh"

# mouse support (select panes / scroll with the mouse)
tmux set-option -t "$SESSION_NAME" mouse on

tmux select-window -t "$W_roscore"
tmux -2 attach-session -t "$SESSION_NAME"
