#!/bin/bash

# Path to the ffmpeg binary
FFMPEG_BIN="/usr/local/bin/ffmpeg"

# Input RTMP stream URL
INPUT_STREAM="rtmp://192.168.1.44/live/$1"

# Output directory
OUTPUT_DIR="/Users/holgerlersch/webprojects/fu-master/receive_stream/incomingstreams"

# Output stream file
OUTPUT_STREAM="$OUTPUT_DIR/tmp/$1.m3u8"

# Output MP4 file
OUTPUT_FILE="$OUTPUT_DIR/$1.flv"

# Log file for FFmpeg output and errors
LOG_FILE="$OUTPUT_DIR/$1_ffmpeg.log"

# Run FFmpeg to transcode and save the stream when a stream is received
$FFMPEG_BIN -i "$INPUT_STREAM" \
            -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k \
            -c:a aac -ar 44100 -ac 2 -b:a 96k \
            -f hls -hls_time 5 -hls_list_size 10 -hls_flags delete_segments "$OUTPUT_STREAM" \
            -c copy -f mp4 "$OUTPUT_FILE";

# Save the FFmpeg process ID to a file
echo $! > "$OUTPUT_DIR/$1.pid"            