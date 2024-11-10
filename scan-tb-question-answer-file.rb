#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'amazing_print'
require 'time'
require 'date'
require 'logger'
require 'pry'
require 'CSV'
require 'facets/enumerable/find_yield'
require_relative 'regexes'

def get_emojis_from_regex(emoji_regex, content, unknown_name)
  emoji_regex.find_yield({ emoji: UNKNOWN_EMOJI, matching_text: nil, name: unknown_name }) \
  { |er| { emoji: er[:emoji], matching_text: Regexp.last_match(1), name: er[:name] } if content =~ er[:regex] }
end

def get_binary_flags_from_regex(emoji_regex, content, unknown_name)
  binary_flags = []
  match = false
  emoji_string = ''
  emoji_regex.each do |r|
    if r[:regex] =~ content
      emoji_string += r[:emoji]
      binary_flags.push({ name: r[:name], value: 1 })
      match = true
    else
      binary_flags.push({ name: r[:name], value: 0 })
    end
  end
  if match
    binary_flags.push({ name: unknown_name, value: 0 })
  else
    binary_flags.push({ name: unknown_name, value: 1 })
    emoji_string = UNKNOWN_EMOJI
  end
  {flags: binary_flags, emoji: emoji_string}
end

def get_windows_version(name, logger)
  logger.debug "get_windows_version: name: #{name}"
  return 7 if name =~ /win[a-z\- ]*7/i
  return 8 if name =~ /win[a-z\- ]*8/i
  return 10 if name =~ /win[a-z\- ]*10/i
  return 11 if name =~ /win[a-z\- ]*11/i

  0
end

logger = Logger.new($stderr)
logger.level = Logger::DEBUG

if ARGV.length < 2
  puts "usage: #{$PROGRAM_NAME} question_filename answer_filename"
  exit
end

QUESTION_FILENAME = ARGV[0].freeze
ANSWER_FILENAME = ARGV[1].freeze

OUTPUT_FILENAME = "regex-matches-#{QUESTION_FILENAME}".freeze
logger.debug("output_filename: #{OUTPUT_FILENAME}")

all_questions = CSV.read(QUESTION_FILENAME, headers: true)
all_answers = CSV.read(ANSWER_FILENAME, headers: true)

all_questions.each do |q|
  content = "#{q['title']} #{q['content']}"
  question_creator = q['creator']
  id = q['id']
  emoji_str = 'OS:'

  all_answers.select { |a| a['question_id'] == id }.each do |a|
    content += " #{a['content']}" if a['creator'] == question_creator
  end
  content += " #{q['tags']}"
  content.downcase!
  logger.debug "question id: #{id}"

  os_flags_and_emoji = get_binary_flags_from_regex(OS_EMOJI_ARRAY, content, 'os:unknown')
  os_flags = os_flags_and_emoji[:flags]
  os_flags.each { |f| q[f[:name]] = f[:value] }
  emoji_str += os_flags_and_emoji[:emoji]
  if os_flags_and_emoji[:emoji] == WINDOWS_EMOJI
    windows_version = get_windows_version(content, logger) 
    emoji_str += "#{windows_version}"
    q['windows'] = windows_version
  else
    q['windows'] = 0
  end
  logger.debug "windows version: #{q['windows']}"
  email_flags_and_emoji = get_binary_flags_from_regex(EMAIL_EMOJI_ARRAY, content, 'm:unknown')
  email_flags_and_emoji[:flags].each { |f| q[f[:name]] = f[:value] }
  emoji_str += "E:#{email_flags_and_emoji[:emoji]}"
  oauth_flags_and_emoji = get_binary_flags_from_regex(OAUTH_EMOJI_ARRAY, content, 'oa:unknown')
  oauth_flags_and_emoji[:flags].each { |f| q[f[:name]] = f[:value] }
  emoji_str += "O:#{oauth_flags_and_emoji[:emoji]}"
  av_flags_and_emoji = get_binary_flags_from_regex(ANTIVIRUS_EMOJI_ARRAY, content, 'av:unknown')
  av_flags_and_emoji[:flags].each { |f| q[f[:name]] = f[:value] }
  emoji_str += "AV:#{av_flags_and_emoji[:emoji]}"
  q['emoji'] = emoji_str
end
CSV.open(OUTPUT_FILENAME, 'w') do |csv_object|
  csv_object << all_questions.headers
  all_questions.each { |row_array| csv_object << row_array }
end
