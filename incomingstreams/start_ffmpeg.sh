#!/bin/bash

# Path to the ffmpeg binary
FFMPEG_BIN="/usr/local/bin/ffmpeg"

# Input RTMP stream URL
INPUT_STREAM="rtmp://192.168.1.44/live/$1"

# Output directory
OUTPUT_DIR="/Users/holgerlersch/webprojects/fu-master/receive_stream/incomingstreams"

# Output MP4 file
OUTPUT_FILE="$OUTPUT_DIR/$1.flv"

# Log file for FFmpeg output and errors
LOG_FILE="$OUTPUT_DIR/$1_ffmpeg.log"

# Run ffmpeg to save stream as FLV file
$FFMPEG_BIN -i "$INPUT_STREAM" -c copy "$OUTPUT_FILE" > "$LOG_FILE" 2>&1 &

# Save the FFmpeg process ID to a file
echo $! > "$OUTPUT_DIR/$1.pid"