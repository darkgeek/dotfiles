function load-ssh-agent
    # Try to start ssh-agent
	if ! pgrep -u "$USER" ssh-agent > /dev/null
		ssh-agent > ~/.ssh-agent-thing
	end
	if test "$SSH_AGENT_PID" = ""
		bass source ~/.ssh-agent-thing
	end
end
