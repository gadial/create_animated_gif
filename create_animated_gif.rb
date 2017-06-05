#!/usr/bin/env ruby
FPS = 25
DELAY = 100 / FPS
video_file = ARGV[0]
start_time_flag = ARGV[1] ? "-ss #{ARGV[1]}" : ""
finish_time_flag = ARGV[2] ? "-to #{ARGV[2]}" : ""
scale_string = ARGV[3] ? "-vf scale=iw*#{ARGV[3]}:ih*#{ARGV[3]}" : ""
video_name = video_file.split(".").first
temp_video_dir = "#{video_name}_temp"
`mkdir -p #{temp_video_dir}`
`ffmpeg -i #{video_file} #{start_time_flag} #{finish_time_flag} #{scale_string} -r #{FPS} '#{temp_video_dir}/frame-%03d.png'`
puts "convert -delay #{DELAY} -loop 0 #{temp_video_dir}/*.png #{video_name}.gif"
`convert -delay #{DELAY} -loop 0 #{temp_video_dir}/*.png #{video_name}.gif`
`rm -fr #{temp_video_dir}`
