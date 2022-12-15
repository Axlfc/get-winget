function git_pull_function {
	git pull "$args[0]"
}
Set-Alias pull git_pull_function


function git_push_function {
	git push "$args[0]"
}
Set-Alias push git_push_function


function git_commit_function {
	git commit -am "$args[0]"
}
Set-Alias commit git_commit_function


function git_checkout_function {
	git checkout "$args[0]"
}
Set-Alias checkout git_checkout_function


function git_clone_function {
	git clone "$args[0]"
}
Set-Alias clone git_clone_function


function git_branch_function {
	git branch "$args[0]"
}
Set-Alias branch git_branch_function


function git_status_function {
	git status
}
Set-Alias status git_status_function


function git_add_function {
	
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	git add $args} 
}
Set-Alias add git_add_function


function git_hard_function {
	git reset --hard
}
Set-Alias hard git_hard_function


function git_fetch_function {
	git fetch
}
Set-Alias fetch git_fetch_function


function git_config_function {
	git config user.name "$args[0]"
	git config user.email "$args[1]"
}
Set-Alias config git_config_function


function git_unstage_function {
	
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	git rm --cached $args} 
}
Set-Alias unstage git_unstage_function

