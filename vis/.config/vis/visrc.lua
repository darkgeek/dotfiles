require('vis')

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
        vis:command('set number')
        vis:command('set theme dark-16')
end)
