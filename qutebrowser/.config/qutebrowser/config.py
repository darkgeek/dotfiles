# Tell qutebrowser only load settings from this file
config.load_autoconfig(False)

# Set default page
c.url.default_page = 'about:blank'
c.url.start_pages = 'about:blank'
# Set default page End

# Set dark mode
dark_mode_exclude_list = [
'*://trophymanager.com/*',
'*://footballmanagerproject.com/*'
]

c.colors.webpage.darkmode.enabled = True
for site in dark_mode_exclude_list:
    config.set('colors.webpage.darkmode.enabled', False, site)

c.colors.webpage.preferred_color_scheme = 'dark'
# Set dark mode End

# Set keybinding
config.bind('to', 'cmd-set-text -s :open -t')
config.bind('zf', 'forward')
config.bind('zz', 'back')
# Set keybinding End
