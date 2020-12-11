# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#    Copyright (C) 2016-2020 Chuan Ji <chuan@jichu4n.com>                     #
#    Copyright (C) 2020 Justin Yang 
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# A fish shell script for printing execution time for each command.
#
# Forked from https://github.com/jichu4n/fish-command-timer
#
# Requires fish 2.2 or above.

# SETTINGS
# ========
#
# The threshold to print 
# Only command duration greater than this value will be printed
if not set -q cmd_duration_threshold
    set -x cmd_duration_threshold 5000
end

# The decimals used to print seconds
if not set -q cmd_duration_decimals
    set -x cmd_duration_decimals 3
end

# The color of the output.
#
# This should be a color string accepted by fish's set_color command, as
# described here:
#
#     http://fishshell.com/docs/current/commands.html#set_color
#
# If empty, disable colored output. Set it to empty if your terminal does not
# support colors.
if not set -q fish_command_timer_color
    set fish_command_timer_color cyan
end

# IMPLEMENTATION
# ==============

# fish_command_timer_strlen:
#
# Command to print out the length of a string. This is required because the expr
# command behaves differently on Linux and OS X. On fish 2.3+, we will use the
# "string" builtin.
if type string > /dev/null 2> /dev/null
    function fish_command_timer_strlen
        string length "$argv[1]"
    end
else if expr length + "1" > /dev/null 2> /dev/null
    function fish_command_timer_strlen
        expr length + "$argv[1]"
    end
else if type wc > /dev/null 2> /dev/null; and type tr > /dev/null 2> /dev/null
    function fish_command_timer_strlen
        echo -n "$argv[1]" | wc -c | tr -d ' '
    end
else
    echo 'No compatible string, expr, or wc commands found, not enabling fish command timer'
end

# The fish_postexec event is fired after executing a command line.
function fish_command_timer_postexec -e fish_postexec
    if ! test $CMD_DURATION -gt $cmd_duration_threshold
        return
    end

    # Omit empty command (occurs when you type nothing and just press enter, which won't update $CMD_DURATION previously set)
    if test -z $argv
        return
    end

    set -l duration "⌚"(calculate-cmd-duration)
    set -l duration_with_color (set_color $fish_command_timer_color)"$duration"(set_color normal)
    set -l duration_str_length (fish_command_timer_strlen $duration)  
    # Combine status string and timing string.
    set -l output_length (math $duration_str_length + 1)
    
    # Move to the end of the line. This will NOT wrap to the next line.
    echo -ne "\033["{$COLUMNS}"C"
    # Move back output_length columns.
    echo -ne "\033["{$output_length}"D"
    # Finally, print output.
    echo -e "$duration_with_color"
end

