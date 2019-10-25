function fact($n) {
   if ($n -le 2) {
      return 1
   } else {
      return ($n * (fact($n - 1)))
   }
}
fact(10)

Invoke-History 2

${"I" like $} = 5.1

$myString = @"
This is the first line
of a very long string. A "here sting"
let you to create blocks of text
that span several lines.
"@

$myString

$PSVersionTable
