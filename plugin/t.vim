
let sym="car"
echo  system("emacs --batch --eval \"(princ (format \\\"%s\\\" (ignore-errors (or (documentation \'" .  sym . ")))))\"")
