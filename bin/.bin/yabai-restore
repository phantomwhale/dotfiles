filename=${1:-desktop}
directory=$HOME/.config/yabai/layouts/$(hostname)

mkdir -p $directory

yabai -m query --windows | jq -re '.[] | select(.minimized != 1) | "yabai -m window \(.id) --display \(.display) --space \(.space) --move abs:\(.frame.x):\(.frame.y) --resize abs:\(.frame.w):\(.frame.h)"' > $directory/$filename.sh

if [[ $? != 0 ]] ; then
  echo -n "Yabai: failed to save"
  exit 1
fi

chmod +x $directory/$filename.sh
