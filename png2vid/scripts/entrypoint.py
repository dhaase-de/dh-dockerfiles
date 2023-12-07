#!/usr/bin/env python3

import argparse
import pathlib
import shlex
import subprocess
import sys


def get_args():
    parser = argparse.ArgumentParser(
        description="Convert a series of images into a video",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument("-c", "--crf", type=int, default=17, help="CRF used to control the quality of the video. It is a value between 0 and 51, while lower values produce a better quality. For details, see https://trac.ffmpeg.org/wiki/Encode/H.264#a1.ChooseaCRFvalue")
    parser.add_argument("-f", "--framerate", type=int, default=24, help="Framerate of the video to be created.")
    parser.add_argument("-p", "--image-pattern", type=str, default="*.png", help="Glob pattern of the filenames to be used as input. Remember to use single quotes to prevent a shell expansion.")
    parser.add_argument("-w", "--work-path", type=pathlib.Path, default=".", help="Work path where the input images are located.")
    parser.add_argument("-o", "--out-filename", type=str, default="out.mp4", help="Name of the video file to generate.")

    (args, passthrough_args) = parser.parse_known_args()
    return (args, passthrough_args)


def main():
    (args, passthrough_args) = get_args()
    
    # construct the ffmpeg call
    call_args = [
        "ffmpeg",
        "-framerate", str(args.framerate),
        "-pattern_type", "glob",
        "-i", args.image_pattern,
        "-c:v", "libx264",
        "-crf", str(args.crf),
        "-pix_fmt", "yuv420p",
    ]
    
    # whatever we can't parse will be appended to the ffmpeg call
    call_args += passthrough_args

    # the output filename comes last
    call_args += [args.out_filename]
    
    # print the ffmpeg call and then run it
    print(" ".join([shlex.quote(call_arg) for call_arg in call_args]))
    print("=" * 80)
    subprocess.run(call_args)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("ERROR: {} ({})".format(e, type(e).__name__))
        sys.exit(1)

