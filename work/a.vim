let g:Complete_data = map(getcompletion('','function'), 'v:val . ","')

arglist		file names in argument list
augroup		autocmd groups
   buffer		buffer names
   behave		:behave suboptions
   color		color schemes
   command		Ex command (and arguments)
   compiler	compilers
   cscope		|:cscope| suboptions
   dir		directory names
environment	environment variable names
event		autocommand events
expression	Vim expression
file		file and directory names
file_in_path	file and directory names in |'path'|
filetype	filetype names |'filetype'|
function	function name
   help		help subjects
   highlight	highlight groups
   history		:history suboptions
   locale		locale names (as output of locale -a)
   mapclear        buffer argument
   mapping		mapping name
   menu		menus
   messages	|:messages| suboptions
   option		options
   packadd		optional package |pack-add| names
   shellcmd	Shell command
   sign		|:sign| suboptions
   syntax		syntax file names |'syntax'|
   syntime		|:syntime| suboptions
   tag		tags
   tag_listfiles	tags, file names
   user		user names
   var		user variables

   echo trim("3")
