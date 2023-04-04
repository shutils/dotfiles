set runtimepath+=~/.fzf
set runtimepath+=~/.deno/bin/deno

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" .toml file
	let s:rc_dir = expand('~/.vim')
	if !isdirectory(s:rc_dir)
		call mkdir(s:rc_dir, 'p')
	endif
	let s:toml = expand('~/.vim') . '/dein.toml'

	" read toml and cache
	call dein#load_toml(s:toml, {'lazy': 0})

	" end settaddings
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
	call map(s:removed_plugins, "delete(v:val, 'rf')")
	call dein#recache_runtimepath()
endif
