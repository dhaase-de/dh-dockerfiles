#!/usr/bin/env python3

import argparse
import collections
import datetime
import os.path
import pathlib
import shlex
import subprocess
import sys


def now_str():
    return datetime.datetime.now().strftime("%Y-%m-%d__%H-%M-%S__%f")


def human_bytes(byte_count):
    prefixes = collections.OrderedDict()
    prefixes["KiB"] = 1024.0**1
    prefixes["MiB"] = 1024.0**2
    prefixes["GiB"] = 1024.0**3

    count = byte_count
    unit = "bytes"
    for (new_unit, new_scale) in prefixes.items():
        new_count = byte_count / new_scale
        if new_count < 1.0:
            break
        else:
            count = new_count
            unit = new_unit

    if isinstance(count, int):
        # count is an integer -> use no decimal places
        return "{} {}".format(count, unit)
    else:
        # count is a float -> use two decimal places
        return "{:.2f} {}".format(count, unit)


def get_args():
    parser = argparse.ArgumentParser(
        description="Convert a series of images into a video",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument("-c", "--crf", type=int, default=17, help="CRF used to control the quality of the video. It is a value between 0 and 51, while lower values produce a better quality. For details, see https://trac.ffmpeg.org/wiki/Encode/H.264#a1.ChooseaCRFvalue")
    parser.add_argument("-f", "--framerate", type=int, default=24, help="Framerate of the video to be created.")
    parser.add_argument("-p", "--image-pattern", type=str, default="*.png", help="Glob pattern of the filenames to be used as input. Remember to use single quotes to prevent a shell expansion.")
    parser.add_argument("-w", "--work-path", type=pathlib.Path, default=".", help="Work path where the input images are located.")
    parser.add_argument("-o", "--out-filename", type=str, default=None, help="Name of the video file to generate. If unset, will be 'out__<datetime>.mp4'.")

    (args, passthrough_args) = parser.parse_known_args()
    return (args, passthrough_args)


def main():
    (args, passthrough_args) = get_args()

    # set output filename
    out_filename = args.out_filename
    if out_filename is None:
        out_filename = f"out__{now_str()}.mp4"
    
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
    call_args += [out_filename]
    
    # print the ffmpeg call and then run it
    print(" ".join([shlex.quote(call_arg) for call_arg in call_args]))
    print("=" * 120)
    subprocess.run(call_args)

    # print filename and size of the generated video file
    print("=" * 120)
    if os.path.exists(out_filename):
        print(f"Output file '{out_filename}' was created ({human_bytes(os.path.getsize(out_filename))})")
    else:
        print(f"Output file '{out_filename}' was NOT created")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("ERROR: {} ({})".format(e, type(e).__name__))
        sys.exit(1)

