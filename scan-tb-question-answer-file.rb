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
  emoji_regex.each do |r|
    if r[:regex] =~ content
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
  end
  binary_flags
end

def get_os_name(emoji, matching_text, name, logger)
  logger.debug "emoji: #{emoji} matching_text: #{matching_text} name: #{name}"
  return name if [MACOS_EMOJI, LINUX_EMOJI].include?(emoji)
  return 'os:unknown' if emoji == UNKNOWN_EMOJI
  return 'os:win7' if matching_text =~ /win[a-z\- ]*7/i
  return 'os:win8' if matching_text =~ /win[a-z\- ]*8/i
  return 'os:win10' if matching_text =~ /win[a-z\- ]*10/i
  return 'os:win11' if matching_text =~ /win[a-z\- ]*11/i

  name
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

regular_expressions = []
all_questions.each do |q|
  content = "#{q['title']} #{q['content']}"
  question_creator = q['creator']
  id = q['id']

  all_answers.select { |a| a['question_id'] == id }.each do |a|
    content += " #{a['content']}" if a['creator'] == question_creator
  end
  content += " #{q['tags']}"
  content.downcase!
  logger.debug "question id: #{id}"

  os_flags = get_binary_flags_from_regex(OS_EMOJI_ARRAY, content, 'os:unknown')
  os_flags.each { |f| q[f[:name]] = f[:value] }
  email_flags = get_binary_flags_from_regex(EMAIL_EMOJI_ARRAY, content, 'm:unknown')
  email_flags.each { |f| q[f[:name]] = f[:value] }
  oauth_flags = get_binary_flags_from_regex(OAUTH_EMOJI_ARRAY, content, 'oa:unknown')
  oauth_flags.each { |f| q[f[:name]] = f[:value] }
  av_flags = get_binary_flags_from_regex(ANTIVIRUS_EMOJI_ARRAY, content, 'av:unknown')
  av_flags.each { |f| q[f[:name]] = f[:value] }
  # os_emoji_content[:name] = get_os_name(os_emoji_content[:emoji], os_emoji_content[:matching_text],
  #                                       os_emoji_content[:name], logger)
  # topics_emoji_content = get_emojis_from_regex(TOPICS_EMOJI_ARRAY, q['tags'], 't:unknown')
  # email_emoji_content = get_emojis_from_regex(EMAIL_EMOJI_ARRAY, content, 'm:unknown')
  # av_emoji_content = get_emojis_from_regex(ANTIVIRUS_EMOJI_ARRAY, content, 'av:unknown')
  # userchrome_emoji_content = get_emojis_from_regex(USERCHROME_EMOJI_ARRAY, content, 'uc:unknown')

  #  regular_expression_row is:
  #  id, date, title, os, topic, email, antivirus, userchrome, tags
  #  128958, 2023-04-01, emoji;windows 10;win10, emoji;fix-problems;fix_problmes, emoji;outlook;microsoftemail, emoji:avtext;kaspersky, emoji:userchrometext;unsupported_customizations, tags
end
CSV.open(OUTPUT_FILENAME, 'w') do |csv_object|
  csv_object << all_questions.headers
  all_questions.each { |row_array| csv_object << row_array }
end
