#!/bin/sh

SHARED_DIR="/shared"
LOCK_FILE="$SHARED_DIR/.lock"

CONTAINER_ID=$(cat /proc/sys/kernel/random/uuid)

current_file=""

cleanup() {
    if [ -n "$current_file" ]; then
        rm -f "$current_file"
    fi
    exit 0
}

trap cleanup INT TERM

exec 9>>"$LOCK_FILE"

seq=1
while true; do
    flock -x 9
    i=1
    while true; do
        if [ "$i" -lt 10 ]; then
            name="00$i"
        elif [ "$i" -lt 100 ]; then
            name="0$i"
        else
            name="$i"
        fi
        target="$SHARED_DIR/$name"
        if [ ! -e "$target" ] && [ ! -L "$target" ]; then
            echo "$CONTAINER_ID $seq" > "$target"
            current_file="$target"
            break
        fi
        i=$((i + 1))
    done
    flock -u 9

    sleep 1
    rm -f "$current_file"
    current_file=""
    seq=$((seq + 1))
    sleep 1
done
