function! ColorMe()
   let colors = getcompletion('', 'color')
   let k = len(colors)
   let i = 0
   function! ColorHandler(timer) closure
      if i == k
         let i = 0
      else
         let i = i + 1
      endif
      try 
         call popup_create(colors[i], #{
                  \ line: 1,
                  \ col: "cursor+" . (getwininfo()['variables']['width'] - getcurpos()[2]  - 30)
                  \ ,minwidth: 20,
                  \ time: 3000,
                  \ tabpage: -1,
                  \ zindex: 300,
                  \ drag: 1,
                  \ highlight: 'WarningMsg',
                  \ border: [],
                  \ close: 'click',
                  \ padding: [0,1,0,1],
                  \ })
         exec 'colorscheme ' . colors[i]
      catch
      endtry
   endfunction
   let timer = timer_start(5000, 'ColorHandler',  { 'repeat':  -1 })
endfunction

