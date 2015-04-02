#!/bin/sh

function logcat() {
  # see how may devices are attached
  num_devices=`expr $(adb devices | tail -n +2 | cut -sf 1 | wc -l | xargs)`

  # multiple devices
  if [ $num_devices == 1 ]; then
    # only one device
    adb logcat -v threadtime
  else
    # print out each device name along with index
    devices=$(adb devices | tail -n +2 | cut -sf 1)

    declare -i index=0
    echo ""
    echo ""
    echo "Index   |      Device"
    echo "--------------------------------------------"
    for SERIAL in $devices;
    do
      printf "  $index     |     "
      adb -s $SERIAL shell getprop | grep ro.product.model | cut -d ':' -f2
      index=index+1
    done
    echo "--------------------------------------------"
    echo ""

    printf "Which device (or Enter for default 0): "
    read i
    while [[ "$i" -gt "$num_devices" || "$i" -lt 0 ]]; do
      printf "Try again (0 - $(($num_devices-1))): "
      read i
    done

    # increment i since the cut operation is 1 based
    i=$((i+1))

    device=$(echo $devices | cut -d ' ' -f$i)
    command="adb -s $device logcat -v threadtime"
    echo "-> $command"
    $command
  fi
}
