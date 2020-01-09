" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.str    setfiletype stratego
  au! BufRead,BufNewFile *.sdf    setfiletype sdf
  au! BufRead,BufNewFile *.sls    setfiletype scheme
  au! BufRead,BufNewFile *.sps    setfiletype scheme
  au! BufRead,BufNewFile *.ms     setfiletype scheme
  au! BufRead,BufNewFile *.stex   setfiletype tex
augroup END
