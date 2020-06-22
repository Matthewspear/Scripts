#!/usr/bin/python

import sys
import subprocess
import re

def extract_playlist_title(json_str):
    regex = r"\"playlist_title\": \"(.*?)\","
    matches = re.finditer(regex, json_str, re.MULTILINE)

    for matchNum, match in enumerate(matches, start=1):
        for groupNum in range(0, len(match.groups())):
            groupNum = groupNum + 1
        return match.group(groupNum)

def main():
    if len(sys.argv) < 2:
        print("Provide a playlist url")
        exit(-1)

    playlist_url = str(sys.argv[1])
    process = subprocess.Popen(['youtube-dl', playlist_url, '-s', '--dump-single-json', '-e', '--get-id'], 
                               stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT)

    stdout, stderr = process.communicate()

    output = stdout.split('\n')
    json_info = output[-2]

    title = extract_playlist_title(json_info)
    output_string = "### " + str(title) + "\n"

    for counter, value in enumerate(output[:-2]):
        
        if counter % 2 == 0:
            output_string += "    - {{[[TODO]]}} [" + value + "]"
        
        if counter % 2 == 1:
            output_string += "(https://www.youtube.com/watch?v=" + value + ")\n"

    print(output_string)

if __name__ == "__main__":
    main()

