MACOS_EMOJI = '🍎'.freeze
LINUX_EMOJI = '🐧'.freeze
WINDOWS_EMOJI = '🪟'.freeze
UNKNOWN_EMOJI = '❓'.freeze
GMAIL_EMOJI = '📮'.freeze
MICROSOFT_EMAIL_EMOJI = '💌'.freeze
PROTONMAIL_EMOJI = '📨'.freeze
FASTMAIL_EMOJI = '📧'.freeze
YAHOOEMAIL_EMOJI = '🇾'.freeze
MAILFENCE_EMOJI = '📯'.freeze
KASPERSKY_EMOJI = '🇰'.freeze
BITDEFENDER_EMOJI = '🇧'.freeze
AVAST_EMOJI = '🅰'.freeze
AVIRA_EMOJI = '🇦'.freeze
ZONEALARM_EMOJI = '🇿'.freeze
COMODO_EMOJI = '🇨'.freeze
ESET_EMOJI = '🇪'.freeze
FSECURE_EMOJI = '🇫'.freeze
MALWAREBYTES_EMOJI = '🇲'.freeze
MCAFEE_EMOJI = 'Ⓜ'.freeze
NORTON_EMOJI = '🇳'.freeze
TRENDMICRO_EMOJI = '🇹'.freeze
MSDEFENDER_EMOJI = '🇩'.freeze
SOPHOS_EMOJI = '🇸'.freeze
USERCHROME_EMOJI = '🪛'.freeze
# Topics in the AAQ:
OTHER_EMOJI = '👽'.freeze # other in AAQ
FIX_PROBLEMS_EMOJI = '🚧'.freeze # fix-problems
CALENDAR_EMOJI = '📅'.freeze # calendar
CUSTOMIZE_EMOJI = '🔩'.freeze # customize
DOWNLOAD_AND_INSTALL_EMOJI = '🛠'.freeze # download-and-install
PRIVACY_AND_SECURITY_EMOJI = '🔏'.freeze # privacy-and-security
OAUTH_EMOJI = '⭕'.freeze

TOPICS_EMOJI_ARRAY = [
  { regex: /(fix-problems)/i, emoji: FIX_PROBLEMS_EMOJI, name: 't:fix_problems' },
  { regex: /(calendar)/i, emoji: CALENDAR_EMOJI, name: 't:calendar' },
  { regex: /(download-and-install)/i, emoji: DOWNLOAD_AND_INSTALL_EMOJI, name: 't:download_and_install' },
  { regex: /(privacy-and-security)/i, emoji: PRIVACY_AND_SECURITY_EMOJI, name: 't:privacy_and_security' },
  { regex: /(customize)/i, emoji: CUSTOMIZE_EMOJI, name: 't:customize' },
  { regex: /(other)/i, emoji: OTHER_EMOJI, name: 't:other' }
]
USERCHROME_EMOJI_ARRAY = [
  { regex: /(userchrome|usercontent)/i, emoji: USERCHROME_EMOJI, name: 'uc:unsupported_customization' }
].freeze

OAUTH_EMOJI_ARRAY = [
  { regex: /oauth/i, emoji: OAUTH_EMOJI, name: 'oa:oauth' }
].freeze

OS_EMOJI_ARRAY = [
  {
    regex: /(sequoia|ventura|panther|\
    snow(-| )*leopard|leopard|jaguar|monterey|mavericks|sonoma|\
    sierra|el(-| )*capitan|mojave|catalina|big(-| )*sur|yosemite|\
    mac(-| )*os(-| )*x*[0-9]*\.*[0-9]*\.*[0-9]*|osx|os-x)/i,
    emoji: MACOS_EMOJI,
    name: 'os:macos'
  },
  {
    regex: /(linux|ubuntu|redhat|debian|bsd)/i,
    emoji: LINUX_EMOJI,
    name: 'os:linux'
  },
  { regex: /(windows-7|windows-8|windows-10|windows-11|windows 10|win 10|windows 11|win 11|windows 7|win 7|\
  windows 8|win 8|windows7|windows8|windows10|windows11|\
      win7|win10|win8|win11|win-7|win-8|win-10|win-11)/i,
    emoji: WINDOWS_EMOJI,
    name: 'os:windows' }
].freeze

ANTIVIRUS_EMOJI_ARRAY = [
  {
    regex: /(kaspersky)/i,
    emoji: KASPERSKY_EMOJI,
    name: 'av:kaspersky'
  },
  { regex: /(bitdefender)/i,
    emoji: BITDEFENDER_EMOJI,
    name: 'av:bitdefender' },
  { regex: /(avast|avg)/i,
    emoji: AVAST_EMOJI,
    name: 'av:avast' },
  { regex: /(avira)/i,
    emoji: AVIRA_EMOJI,
    name: 'av:avira' },
  {
    regex: /(zonealarm|zone alarm|checkpoint|check point|check-point)/i,
    emoji: ZONEALARM_EMOJI,
    name: 'av:zonealarm'
  },
  {
    regex: /(comodo)/i,
    emoji: COMODO_EMOJI,
    name: 'av:comodo'
  },
  {
    regex: /( eset |nod32)/i,
    emoji: ESET_EMOJI,
    name: 'av:eset'
  },
  {
    regex: /(fsecure|f-secure|f secure)/i,
    emoji: FSECURE_EMOJI,
    name: 'av:fsecure'
  },
  {
    regex: /(malwarebytes)/i,
    emoji: MALWAREBYTES_EMOJI,
    name: 'av:malwarebytes'
  },
  {
    regex: /(mcafee)/i,
    emoji: MCAFEE_EMOJI,
    name: 'av:mcafee'
  },
  {
    regex: /(norton)/i,
    emoji: NORTON_EMOJI,
    name: 'av:norton'
  },
  { regex: /(sophos)/i,
    emoji: SOPHOS_EMOJI,
    name: 'av:sophos' },
  {
    regex: /(trendmicro|titanium)/i,
    emoji: TRENDMICRO_EMOJI,
    name: 'av:trendmicro'
  },
  {
    regex: /(defender)/i,
    emoji: MSDEFENDER_EMOJI,
    name: 'av:defender'
  }
]

# FIXME:  Add email providers to regex that are hosted by Yahoo e.g. ameritech, att, bellsouth etc #3
# https://github.com/rtanglao/rt-tb-noto-emoji-2023/issues/3

EMAIL_EMOJI_ARRAY = [
  {
    regex: /(gmail|google mail|googlemail)/i,
    emoji: GMAIL_EMOJI,
    name: 'm:gmail'
  },
  {
    regex: /(live(\.|-)*com|msn|ms365|outlook|office365|office 365|\
hotmail|livemail|passport|microsoft365|microsoft 365|\
o365|ms 365|verizon|microsoft mail|microsoftmail|\
timewarner|twc|godaddy|msexchange|ms exchange|\
microsoft exchange|microsoftexchange|\
spectrum|time warner|roadrunner)/i,
    emoji: MICROSOFT_EMAIL_EMOJI,
    name: 'm:microsoftemail'
  },
  {
    regex: /(protonmail|proton\.me|pm\.me)/i, emoji: PROTONMAIL_EMOJI,
    name: 'm:protonmail'
  },
  {
    regex: /(fastmail.fm|fastmail)/i,
    emoji: FASTMAIL_EMOJI,
    name: 'm:fastmail'
  },
  {
    regex: /(yahoo|ameritech|at&t|att.net|bellsouth|currently.com|nvbell|pacbell|prodigy|sbcglobal|snet|swbell|wans)/i,
    emoji: YAHOOEMAIL_EMOJI,
    name: 'm:yahooemail'
  },
  {
    regex: /(mailfence)/i,
    emoji: MAILFENCE_EMOJI,
    name: 'm:mailfence'
  }
].freeze
