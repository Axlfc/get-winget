function touch_function {
	New-Item "$args"
}
Set-Alias touch touch_function


function find_function {
	Get-ChildItem -Filter "$args" -Recurse -File
}
Set-Alias find find_function


function ping_function {
	Test-Connection "$args" | Format-Table -AutoSize
}
Set-Alias ping ping_function


function webserver_function {
	start http://localhost:4000/
	bundle exec jekyll serve
}
Set-Alias webserver webserver_function


function git_pull_function {
	git pull "$args"
}
Set-Alias pull git_pull_function


function git_push_function {
	git push "$args"
}
Set-Alias push git_push_function


function git_commit_function {
	git commit -am "$args"
}
Set-Alias commit git_commit_function


function git_checkout_function {
	git checkout "$args"
}
Set-Alias checkout git_checkout_function


function git_clone_function {
	git clone "$args"
}
Set-Alias clone git_clone_function


function git_branch_function {
	git branch "$args"
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

