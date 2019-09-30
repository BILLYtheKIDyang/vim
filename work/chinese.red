HEADER IMAGE

Home : Getting Started
Getting Started With Red
By Nick Antonaccio
Updated 4-1-2016
Contents:
1. Downloading the Red Interpreter
2. Compiling Native Red Apps From Source
3. Red Fundamentals
3.1 Functions
3.2 Data Persistence - Red Requires No Database System
3.3 Variables
3.4 Conditional Evaluations
3.5 Using Text Strings and Concatenation
3.6 Lists
3.7 Loops
3.8 User Interfaces
3.9 User Created Functions
3.10 Handling Errors
4. Some Rote GUI, File, and Data List Examples in Rebol
4.1 Basic GUI Examples
4.2 Some GUI Examples Using Lists and Loops
4.3 Building a Basic CRUD (create, read, update, delete) Contacts App
5. A Few More Complete App Examples
5.1 Tip Calculator
5.2 Tile Game
5.3 Generic Calculator
5.4 Coin Flip
5.5 Additional Example Apps to Study
1. Downloading the Red Interpreter
The most current official binary downloads of the Red interpreter are available at http://www.red-lang.org/p/download.html. At the moment, the most recent version available at that link is 0.6.0. You can paste code examples directly into the console, or drag script files onto the interpreter executable to run them.

2. Compiling Native Red Apps From Source
Red is being actively developed, and new features are available regularly. To use the most recent development version of Red on any supported platform, or to produce native binaries for your chosen platform, you can compile your Red scripts using the Red source code:

Download the source repository at https://github.com/red/red. Click the "Download Zip" link, then unzip the package to a folder on your hard drive. For the purpose of this tutorial, we'll assume that you've unzipped the package into C:\ on a Windows machine.
Download the Rebol interpreter from http://www.rebol.com/download-core.html, and copy it directly into the root directory of the unpacked source folder above (i.e., C:\red\)
That's it. To compile a script:

Open the Rebol interpreter
At the console, type "do/args %red.r {%yourscript.red}"
When compilation is complete, you'll see the file name of the created executable displayed (i.e., yourscript.exe).

That's all it takes to get Red programs running from source.

NOTE: the console will allow you to see results much more quickly and naturally. You'll notice that some interactive examples are wrapped in "do []". This allows the code to be pasted into the interpreter before functions such as "ask", which require user input, are evaluated.

3. Red Fundamentals
3.1 Functions
Functions are words which perform actions upon data "arguments" (or "parameters"). The 'print function prints some text to the Red console. In the following code, 'print is the function, "Hello World" is the argument. Try pasting this example into the Red console:

print "Hello World"
The 'halt function doesn't require any argument. It just stops the program and displays the console:

halt
The 'request-file function pops up a dialog which allows the user to select a file from the local file system:

request-file
In Red, some functions have optional "refinements", which allow the function to accept a variety of potentially useful parameters. Here are some refinements of the 'request-file function. Try them in the console:

request-file/file %test.red
request-file/file/save %test.red
3.1.1 Return Values
The 'ask function returns, or outputs, the text entered by the user:

ask "Enter some text:  "
When working in the console, the return values of functions are automatically printed. When working in a script file, you can print the return value of a function to the console:

Red []        ; header, because this will be run from a script file
print ask "Enter some text:  "
halt          ; this stops the interpreter from closing after printing
The example below uses the 'print function to display the output of the 'request-dir function, right back to the user:

print request-dir
Note that before the 'print function above can complete its operation, a value first needs to be returned from the 'request-dir function. Because of that requirement, when this code runs, the print function is held up temporarily, and the first thing the user sees is the 'request-dir popup.

Using the output value of one function as the input argument of another function is a routine way of composing code in Red.

3.2 Data Persistence - Red Requires No Database System
To save text data to a hard drive, thumb drive, or other storage medium, use the 'write function. The 'write function takes two arguments: a file location, and the data to be written to that file. Local file names are preceded by the percent symbol (%):

write %mydata "This is some text that I want to save for later."
To retrieve the text later, use the 'read function. You can use the 'print function to print formatted data read from a file, or the 'probe function to view the raw data without any formatting:

print read %mydata

probe read %mydata

你可以从网络上的服务器上读数据，方法与从本地你电脑的磁盘上一样。
You can read from servers at a network/Internet URL, in the same way you read from local drives on your computer:

read http://site.com/mydata.txt

/binary修饰符允许你一字节一字节的读
The /binary refinement allows you to read data byte for byte:

read/binary http://redprogramming.com/Home.html

组合 'write 给 'read 就成下载了：
Combining 'write with 'read performs a download:

write %r.html read/binary http://www.baidu.com/index.html

To store complex structured data types, in any format which is natively understood by Red, use the 'save function:

save %mycontacts ["John" "Bill" "Jane" "Ron" "Sue"]
To load saved structured data, use the "load" function:

probe load %mycontacts
You'll see that Red provides all the required abilities to search, sort, compare, combine, add, remove, change, load, save, and otherwise manipulate persistent data. Together, all these features provide the same capabilities as database systems such as MySQL, SQLite, etc., with a shorter and more consistent learning curve, and more fine grained control of data processing algorithms, all in a tiny, 100% portable tool set. The functions learned, and the set of skills used to manage persistent data structures in Red are also used to tackle many other sorts of problem domains in the language (access to network socket connections, email accounts, graphic displays, console and IO interactions, etc.). This single set of skills is much more broadly applicable in Red, than for example SQL is in other languages (SQL is a domain specific language which can only be applied to processing information in database operations). This consistently applied concept is a basic feature which helps Red maintain simplicity. The issue of managing concurrent access to data by multiple client users is easily solved in Red.

3.3 Variables
Variables are word labels (some series of characters) assigned to represent data in a program. In Red, word labels are created with the colon symbol. Try pasting these examples into the Red console:

name: "John"
probe name
Variables can be changed to hold different values (the data they refer to is variable). The code above prints "John". The code below prints "Bill":

name: "Bill"
probe name
Note that Red is case insensitive. The interpreter treats lower case and capital letters in identifiers the same:

name: "George"
print name
print Name
print NAME
print NaMe
You can assign a variable word label to data returned by requestor functions. This code prints the name of the file which the user selects:

name: request-file
probe name
You can assign a label to data read from a file:

data: read %mydata
probe data
You can assign a label to any block of code, and evaluate (run) that code with the 'do function:

mycode: [print "Hello" halt]
do mycode
3.4 Conditional Evaluations
Most programs make use of "if/then" evaluations: if (this) is true [do this]:

account: -10
if account < 0 [print "Your account is overdrawn."]
"Either" is like if/else evaluations in other languages: if (this) is true [do this] [otherwise do this]. Notice that each separate action block is indented, so that you can clearly see two 2 differentiated actions. Notice also that this interactive example is wrapped in a "do []" block:

do [
    pass: ask "Enter Password:  "
    either pass = "secret" [
        print "Welcome back."
    ] [
        print "Incorrect password."
    ]
]
"Case" can be used to choose between a variety of actions, depending on the situation:

name: "john"
case [
    find name "a" [print {Your name contains the letter "a"}]
    find name "e" [print {Your name contains the letter "e"}]
    find name "i" [print {Your name contains the letter "i"}]
    find name "o" [print {Your name contains the letter "o"}]
    find name "u" [print {Your name contains the letter "u"}]
    true [print {Your name doesn't contain any vowels!}]
]
There are many other conditional evaluation structures in Red, but these are enough to handle most situations.

3.5 Using Text Strings and Concatenation
{Curly braces} can be used instead of quotes, to enclose strings of text which contain quote characters, or multi-line strings:

print {She said "Hi"}

print {
    line 1
    line 2
    line 3
}
The 'trim function provides a number of refinements which are helpful in removing white space from strings:

print trim {
    line 1
    line 2
    line 3
}

print trim/all {
    line 1
    line 2
    line 3
}
The "^/" character is used to represent a carriage return:

print "line 1^/line 2^/line 3"
The "prin" function is used to print text without a carriage return:

prin "no newline " prin "add a newline manually" prin newline  ; "^/"
"Concatenation" is the process of joining together multiple pieces of data. Red uses the 'append function to concatenate text:

print append "Chosen file name: " request-file
Most programs make use of concatenated values which are represented by variable labels, typically obtained from user input, resulting from conditional operations, resulting from various potential program states, or other data items which change dynamically during the operation of the program. Notice that concatenated items can be placed on multiple lines and indented for readability:

do [
    name: ask "Your Name:  "
    file: request-file
    print append append name ", your chosen file is: " file
]
When printing multiple values, there's no need to concatenate. Just put each separate value inside a block, and they will be joined automatically when printed:

name: "John"  birthday: "1-Jan-1999"  phone: "123-234-3456"
prin ["name: " name  "  birthday: " birthday "  phone: " phone]
You can concatenate strings of code, and run that code using the 'do function (this is a simple form of "metaprogramming"):

do [
    code: ask {Enter some code:  }   ; for example, {print "hello"}
    do append {print "Here's your running code..."} code
]
3.6 Lists
Most computer applications deal with some sort of data list(s): lists of coordinates in a graphics program, lists of items (and perhaps their prices, sizes, shipping dates, etc.) in an inventory program, lists of names (and their account numbers, passwords, transaction details, etc.) in a financial program, lists of files in a utility program, emails in an email program, etc. Red's main list structure is called the "series". There are a number of functions built into Red which allow you to add, remove, change, search, sort, compare, combine, load, save, and otherwise manipulate series data. Manipulating characters within strings of text (lists of characters), graphics on screen in a game (list of images and screen locations in a draw block), pieces of data being transferred between network ports, etc. all require knowledge of only that one simple set of functions.

The basic code structure used to store series of data items in Red is called the "block". Just put square brackets around a list of items, and assign it a variable label:

names: ["John" "Dave" "Jane" "Bob" "Sue"]
codes: [2804 9439 2386 9823 4217]
files: [%employees %vendors %contractors %events]
You can pick, find, and sort items from the list using simple functions and constructs:

print pick names 3          ; these two lines do
print names/3               ; exactly the same thing
print find names "Dave"
print sort names
print sort codes
Notice in the sort examples above that each type of data is automatically sorted appropriately (names alphabetically, numbers ordinally, etc.).

Save and load blocks of data using the 'save and 'load functions:

names: ["John" "Dave" "Jane" "Bob" "Sue"]
save %mynames names
loaded-names: load %mynames
probe loaded-names
Mastering series manipulation is a core skill required for Red proficiency. These functions will become thoroughly familiar: pick, find, at, index?, length?, append, remove, insert, extract, copy, replace, select, sort, reverse, head, next, back, last, tail, skip, change, poke, clear, join, intersect, difference, exclude, union, unique, empty?, write, read, save, load.

3.7 Loops
Loops are used to do something to or with each consecutive item in a list. 'Foreach is the most commonly used type of loop in Rebol:

names: ["John" "Dave" "Jane" "Bob" "Sue"]
foreach name names [print name]
The variable labels in loops can be set to any arbitrary word. For example, this example does the exact same thing as the code above:

n: ["John" "Dave" "Jane" "Bob" "Sue"]
foreach i n [print i]
Very often, you'll check each item in a list for a condition, and do something appropriate based on the evaluation of each item:

names: ["John" "Dave" "Jane" "Bob" "Sue"]
foreach name names [
    if find name "j" [print name]
]

numbers: [323 2498 94321 31 82]
foreach number numbers [
    if number > 300 [print form number]
]
You can structure data in a list to form rows and columns. The following foreach loop labels every 3 consecutive pieces of data in the 'mycontacts list as a name, address, and phone value. Notice that "" is used as an empty place holder:

mycontacts: [
    "John Smith" "123 Tomline Lane Forest Hills, NJ" "555-1234"
    "Paul Thompson" "234 Georgetown Pl. Peanut Grove, AL" "555-2345"
    "Jim Persee" "345 Pickles Pike Orange Grove, FL" "555-3456"
    "George Jones" "456 Topforge Court Mountain Creek, CO" ""
    "Tim Paulson" "" "555-5678"
]
foreach [name address phone] mycontacts [
    print name
]
You can use the 'extract function, instead of a 'foreach loop, as a shortcut to get columns of data:

mycontacts: [
    "John Smith" "123 Tomline Lane Forest Hills, NJ" "555-1234"
    "Paul Thompson" "234 Georgetown Pl. Peanut Grove, AL" "555-2345"
    "Jim Persee" "345 Pickles Pike Orange Grove, FL" "555-3456"
    "George Jones" "456 Topforge Court Mountain Creek, CO" ""
    "Tim Paulson" "" "555-5678"
]
probe extract mycontacts 3          ; every 3 items 
                                    ; (the 1st column of above data)
probe extract/index mycontacts 3 3  ; every 3 items, starting with 3rd
                                    ; (the 3rd column of above data)
You can use 'repeat loops much like 'foreach, to count through items in a list. This example sets a counter variable 'i to count from 1 to the length of the names block, incrementing the variable by 1 each time through the loop:

names: ["John" "Dave" "Jane" "Bob" "Sue"]
repeat i (length? names) [
    print append append form i ": " pick names i
]

names: ["John" "Dave" "Jane" "Bob" "Sue"]
repeat i (length? names) [
    print append append pick names i " next: " pick names (i + 1)
]
A 'forever loop just repeats forever, until a 'break function is encountered:

count: 99
forever [
    print append form count " bottles of beer on the wall"
    count: count - 1
    if count = 0 [break]
]
3.8 User Interfaces
3.8.1 Console Apps
Utility scripts often print a quick (non-graphic) display of data to the Red console, or perhaps require a brief answer to a question asked at the console text prompt. You can use the 'ask and 'print functions to do simple console i/o. Save this code to a file and run it (type "do filename.r" in the console):

Red []
user: ask "Username (iwu83):  "
pass: ask "Password (zqo72):  "
either all [user = "iwu83" pass = "zqo72"] [
    print "Welcome back"
] [
    print "Incorrect Username/Password"
]
ask ""
3.8.2 GUI Apps
For most "apps", a GUI (graphic user interface) screen is used to input and output data and to control program flow. Buttons, text fields, drop-down selectors, and other "widgets" allow the user to operate the program. Red provides a simple built-in code dialect for creating interactive GUIs. The word "view" create a window layout. A block holds widget descriptions. The words 'below and 'across are used to set the default sequential position of widgets. Save each of the examples in this section to a .red file, and compile them to see the screens created:

Red [title: "test" needs: 'view]
view [
    below
    button
    field
    text "Red is really pretty easy to program."
    text-list
    check
]
You can adjust the visual characteristics of any widget in a screen layout by following each widget with appropriate modifiers:

Red [title: "test" needs: 'view]
view [
    below
    button red "Click Me"              
    field 400 "Enter some text here"  
    text font-size 16 "Red is really pretty easy to program." purple
    text-list 400x300 data ["line 1" "line 2" "another line"]
    check yellow
]
You can have widgets perform functions, or any block of code, when clicked or otherwise activated. Just put the functions inside another set of brackets after the widget. This is how you get your GUIs to 'do something':

Red [title: "test" needs: 'view]
view [
    button "Click me" [print "You clicked the button."]
]
You can refer to data contained in widgets using the path ("/") syntax. Assign a variable label to any widgets which you want to reference:

Red [title: "test" needs: 'view]
view [
    below
    text "Some action examples.  Try using each widget:"
    button red "Click Me" [
        print "You clicked the red button."
    ]
    f: field 400 "Type some text here, then press [Enter]" [
        print f/text
    ]
    t: text-list 400x300 data ["Select this" "Then this" "Now this"][
        print pick t/data t/selected
    ]
    check yellow [print "You clicked the yellow check box."]
    button "Quit" [unview]    
]

Red [title: "test" needs: 'view]
view [
    below
    a: area                               ; an area widget labeled 'a
    f: field                              ; a field widget labeled 'f
    across
    button "Show" [print a/text]
    button "Save" [write %somedatafile.txt a/text]
    button "Load" [f/text: read %somedatafile.txt]
]

Red [title: "test" needs: 'view]
view [
    below
    t: text-list data [1 2 3]                ; a text-list labeled 't
    button "Show Selected" [print pick t/data t/selected]
]
You can build layouts dynamically using loops, and then display the resulting constructed GUI code:

Red [title: "test" needs: 'view]
gui: copy []
foreach color [red green blue] [
    append gui reduce ['text color]
]
view layout gui
You'll need to learn a lot more about creating GUI screens if you want to create user apps with Red, but you can get a lot done with just the basics demonstrated above.

Take a look through some additional GUI examples which demonstrate interesting widgets and how to use them.

The examples in the second half of this text will explain and demonstrate by rote many common GUI techniques.

3.8.3 Server and CGI Web Apps
Red has network and data/code transfer features built in, which allow you to easily create client-server applications. Client apps can be written in Red, HTML/CSS/Javascript, or any other language which can connect using standard network protocols (HTTP://, TCP, UDP, etc.). Red also provides native "CGI" capabilities, so that server scripts can run on a typical Apache host or any other web server stack, and accept input from HTML web forms, Ajax requests, etc., then print HTML or formatted data responses to appear in the user's web browser.

A complete section at the end of this text is dedicated to creating CGI applications (stand-alone network applications are covered in Quick Start, Part 2). This allows you to create useful web based data management apps, with Red, which can be accessed on mobile devices, or any platform which has a browser.

3.8.4 Faceless Apps
Certain types of utility scripts may not require any interaction with a user. For example, apps that run in the background to perform scheduled file maintenance, to upload routine data backups, to check and update the current system time, etc., don't necessarily need to show you that they're running. Red scripts can run in memory without any front end display.

3.9 User Created Functions
You can create your own functions in Red using the "func" code structure. New functions are assigned a word label with a colon symbol. The label(s) of data arguments which the function will process are listed in a block, then the calculations or other actions which the function performs are included in a following block.

Here's a function called 'triple, which multiplies the number 3 times any given number argument (called 'x here):

triple: func [x] [
    print 3 * x
]
Now you can apply the 'triple function to any argument value, as if that function was a native function word built into the Red language:

triple 4
triple 5
triple 6
print "I just tripled the numbers 4 (12), 5 (15), and 6 (18)"
Think of the 'x argument (parameter) in the function definition above just like some program's command line option - it represents some variable data that you send to the program to do some work with. In the 'triple function, the argument represents whatever number is multiplied by 3, and 'x is the variable placeholder used to represent that parameter value.

The 'does structure is a shortcut for 'func, when no data parameters are needed:

cls: does [loop 100 [print newline]]
cls
3.9.1 Return Values
The last value in a Red function definition is treated as its "return" value. The 'check function below takes a series of string values as its parameter (labeled 'list here), and checks to see if it contains any bad words (in this example, bad words are specified by the characters "--"). This function starts out by setting the variable 'answer to "safe", then uses a 'foreach loop and an 'if condition to see if "--" is found in any of the strings in the series. If at any point the bad characters are found, the 'answer variable is set to "unsafe". At the end of the function the 'answer variable is returned. The function is then run on both the names1 and names2 lists, and the user is shown the returned results:

check: func [list] [
    answer: "safe"
    foreach l list [
        if find l "--" [answer: "unsafe"]
    ]
    answer
]
names1: ["Joe" "Dan" "Sh--" "Bill"]
names2: ["Paul" "Tom" "Mike" "John"]
print append "names1 is " check names1
print append "names2 is " check names2
3.9.2 Libraries
You can save collections of useful functions ("libraries") to a file, and import them with 'do. This saves you from having to retype or paste the code of commonly used function definitions into each new program. Save just the 'check function code above to a file named "myfunctions.red" - be sure to include the rebol[] header when saving code to a file:

Red []
check: func [list] [
    answer: "safe"
    foreach l list [
        if find l "--" [answer: "unsafe"]
    ]
    answer
]
The program from the previous section then looks like this:

Red []
do %myfunctions.red
names1: ["Joe" "Dan" "Sh--" "Bill"]
names2: ["Paul" "Tom" "Mike" "John"]
print append "names1 is " check names1
print append "names2 is " check names2
Imported files can be found on the local file system (i.e., on your hard drive, a thumb drive, etc.), or at a network/Internet URL. For example, if you save the "myfunctions.r" file on your web site server, you could import it like this:

do http://site.com/myfunctions.r
You can actually include any code you want in imported files (not just function definitions). You could put the entire program above into a file on your web site and run it by "do"ing the URL of the file. Importing a file with 'do is exactly the same as copying and pasting the contents of the file into your code, and then executing it.

3.10 Handling Errors
The 'error? and 'try functions can be used together to detect runtime errors in Red code. Use an 'if or other conditional evaluation to handle any error events:

if error? try [0 / 0] [alert "Dividing by zero is an error"]
You can examine error properties by assigning a label to the result of the 'try function:

if error? err: try [0 / 0] [probe err]
The 'attempt function can also be used to handle errors:

attempt [1 / 1]
attempt [0 / 0]
4. Some Rote GUI, File, and Data List Examples in Rebol
This section demonstrates a variety of code patterns which are commonly used to create apps in Red. They make use of user interfaces, functions, variables, string concatenation, lists, loops, conditional evaluations, and other code structures which you've been introduced to already. The examples may seen randomly selected or trivial - just paste or type each of them into a script file, by rote, and then compile/run the code. You'll use variations of each snippet in the 20+ example apps which make up the rest of the tutorial. The first examples focus on performing basic interactions with a user interface, then progress towards handling more interesting data manipulation operations. Pay particular attention to the use of lists and loops, as the examples advance.

4.1 Basic GUI Examples
Create a window with a button:

Red [needs: 'view]
view [
    button "Click Me"
]
When the button is clicked, do something:

Red [needs: 'view]
view [
    button "Click Me" [print "I've been clicked!"]
]
Here's a window with a button and a text entry field labeled 'f. When the button is clicked, print the text currently in the 'f field. Try typing something in the field, then click the button:

Red [needs: 'view]
view [
    f: field "Type here, then click the button"
    button "Click Me" [print f/text]
]
When the button is clicked, write the contents of the field to the file mytext.txt, then print that the file has been saved:

Red [needs: 'view]
view [
    f: field "Type here, then click the button"
    button "Click Me" [
        write %mytext.txt f/text
        print "Saved"
    ]
]
Add another button to read the file contents back into the field. Now you can close the program, run it again, and retrieve the saved text:

Red [needs: 'view]
view [
    f: field 
    button "Save" [
        write %mytext.txt f/text
        print "Saved"
    ]
    button "Load" [
        f/text: form read %mytext.txt
    ]
]
Here's the exact same program as above, except with a text area widget, instead of a one-line field. This forms a simple text editor:

Red [needs: 'view]
view [
    a: area
    button "Save" [
        save %mytext.txt a/text
        print "Saved"
    ]
    button "Load" [
        a/text: load %mytext.txt
    ]
]
Here the text is appended to mylist.txt. Instead of overwriting the file contents each time, each new save operation loads the previous file, then adds an additional new line. The 'append function joins together the loaded text with the new text (along with some newline characters), so that a multi-line log file is created:

Red [needs: 'view]
view [
    below
    f: field "Enter some lines here..."
    button "Save" [
        save %mylist.txt append append load %mylist.txt f/text "^M^/"
        print "Saved"
    ]
    a: area "All log entries will appear here when loaded..."
    button "Load" [
        a/text: form load %mylist.txt
    ]
]
4.2 Some GUI Examples Using Lists and Loops
Now here are some examples which display lists in a GUI layout, using the 'text-list widget:

Red [needs: 'view]
view [
    text-list data ["John" "Dave" "Jane" "Bob" "Sue"]
]
You can display a previously created list:

Red [needs: 'view]
mylist: copy ["John" "Dave" "Jane" "Bob" "Sue"]
view [
    text-list data mylist
]
A 'do block can be used to evaluate code and make changes to the GUI, before a layout is displayed. Here, a blank text-list widget is created, then a block of values is added to it, before being displayed:

Red [needs: 'view]
mylist: copy ["John" "Dave" "Jane" "Bob" "Sue"]
view [
    t: text-list data []
    do [append t/data mylist]
]
You can also add items to a widget, using the action block of another widget:

Red [needs: 'view]
mylist: copy ["John" "Dave" "Jane" "Bob" "Sue"]
view [
    t: text-list data []
    button "Add Items to List" [append t/data mylist]
]
This example uses the 'extract function to create a new list containing just the names from the original list, which is then displayed in the text-list widget:

mylist: copy ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: extract mylist 2
view [
    t: text-list data names
]
This example does the same thing as above, using a 'foreach loop technique. First, a blank 'names list is created using "copy []", then items are added to this list using 'foreach and 'append. We'll use this code pattern going forward, to help familiarize the use of 'foreach, since it is very common in all types of Red apps:

Red [needs: 'view]
mylist: ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: copy []
foreach [n c] mylist [append names n]
view [
    t: text-list data names
]
The "index" of an item in a list is its numerical position in the list. The index of the clicked item in a text-list widget is referred to with "/selected":

Red [needs: 'view]
mylist: ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: extract mylist 2
view [
    t: text-list data names [probe t/selected]
]
You can use a selected index, to pick out actual values from the text-list data block:

Red [needs: 'view]
mylist: ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: copy []
foreach [n c] mylist [append names n]
view [
    t: text-list data names [probe pick t/data t/selected]
]
The word 'face can be used when a widget refers to itself. Here's the same example as above, using 'face instead of 't:

Red [needs: 'view]
mylist: ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: copy []
foreach [n c] mylist [append names n]
view [
    t: text-list data names [
        probe form index? find mylist (pick face/data face/selected)
    ]
]
You can select the next item in a list by adding 1 to the current item's index. In the 'mylist example below, each number value is always found at the next index location, immediately following every name (i.e., "Jane" is at position 5 in the example list, her number 2386, is at position 6). In code, that's thought of as 1 + (Jane's index position):

Red [needs: 'view]
mylist: ["John" 2804 "Dave" 9439 "Jane" 2386 "Bob" 9823 "Sue" 4217]
names: copy []
foreach [n c] mylist [append names n]
view [
    t: text-list data names [
        print form pick mylist (
            1 + index? find mylist (pick t/data t/selected)
        )
    ]
]
4.3 Building a Basic CRUD (create, read, update, delete) Contacts App
Here's the same idea as above, but with more data fields for each name (3 columns of table data, instead of 2). Name, Address, and Phone values can be found at consecutive Name, Name + 1, and Name + 2 positions:

Red [needs: 'view]
mycontacts: [
    "John Smith" "123 Tomline Lane Forest Hills, NJ" "555-1234"
    "Paul Thompson" "234 Georgetown Pl. Peanut Grove, AL" "555-2345"
    "Jim Persee" "345 Pickles Pike Orange Grove, FL" "555-3456"
    "George Jones" "456 Topforge Court Mountain Creek, CO" ""
    "Tim Paulson" "" "555-5678"
]
names: copy []
foreach [name address phone] mycontacts [append names name]
view [
    t: text-list data names [
        print [
            "Name: "
            pick t/data t/selected
            " Address: "
            pick mycontacts (
                1 + index? find mycontacts (pick t/data t/selected)
            )
            " Phone: "
            pick mycontacts (
                2 + index? find mycontacts (pick t/data t/selected)
            )
        ]
    ]
]
Instead of printing some rejoined text, display each data item in a text entry field:

Red [needs: 'view]
mycontacts: copy [
    "John Smith" "123 Tomline Lane Forest Hills, NJ" "555-1234"
    "Paul Thompson" "234 Georgetown Pl. Peanut Grove, AL" "555-2345"
    "Jim Persee" "345 Pickles Pike Orange Grove, FL" "555-3456"
    "George Jones" "456 Topforge Court Mountain Creek, CO" ""
    "Tim Paulson" "" "555-5678"
]
names: copy []
foreach [name address phone] mycontacts [append names name]
view [
    below
    t: text-list data names [
        n/text: pick t/data t/selected
        a/text: pick mycontacts (
            1 + index? find mycontacts (pick t/data t/selected)
        )
        p/text: pick mycontacts (
            2 + index? find mycontacts (pick t/data t/selected)
        )
    ]
    text "Name:"
    n: field
    text "Address:"
    a: field
    text "Phone:"
    p: field
]
Here's a version of the code above, with a nicer layout using the 'panel widget:

Red [needs: 'view]
mycontacts: copy [
    "John Smith" "123 Tomline Lane Forest Hills, NJ" "555-1234"
    "Paul Thompson" "234 Georgetown Pl. Peanut Grove, AL" "555-2345"
    "Jim Persee" "345 Pickles Pike Orange Grove, FL" "555-3456"
    "George Jones" "456 Topforge Court Mountain Creek, CO" ""
    "Tim Paulson" "" "555-5678"
]
names: copy []
foreach [name address phone] mycontacts [append names name]
view [
    t: text-list data names [
        n/text: pick t/data t/selected
        a/text: pick mycontacts (
            1 + index? find mycontacts pick t/data t/selected
        )
        p/text: pick mycontacts (
            2 + index? find mycontacts pick t/data t/selected
        )
    ]
    panel [
        below
        text "Name:"
        n: field 200
        text "Address:"
        a: field 200
        text "Phone:"
        p: field 200
    ]
]
Add items to a block (data displayed in a text-list) by entering text into field widgets:

Red [needs: 'view]
contacts: copy []  names: copy [""]
view [
    t: text-list data names [
        n/text: pick t/data t/selected
        a/text: pick contacts (
            1 + index? find contacts pick t/data t/selected
        )
        p/text: pick contacts (
            2 + index? find contacts pick t/data t/selected
        )
    ]
    panel [
        below
        text "Name:"
        n: field 200
        text "Address:"
        a: field 200
        text "Phone:"
        p: field 200
        button "Add" [
            append contacts reduce [copy n/text copy a/text copy p/text]
            clear names
            foreach [name address phone] contacts [append names name]
        ]
    ]
]
This example uses a function to encapsulate duplicated code (which doesn't shorten the whole program much here, but if the duplicated code was, for example, 20 lines long and used in 5 different places, the whole program would be about 100 lines shorter):

Red [needs: 'view]
extract-names: func [] [
    clear names
    foreach [name address phone] contacts [append names name]
    copy names
]
contacts: copy []  names: copy [""]
view [
    t: text-list data names [
        n/text: pick t/data t/selected
        a/text: pick contacts (
            1 + index? find contacts pick t/data t/selected
        )
        p/text: pick contacts (
            2 + index? find contacts pick t/data t/selected
        )
    ]
    panel [
        below
        text "Name:"
        n: field 200
        text "Address:"
        a: field 200
        text "Phone:"
        p: field 200
        button "Add" [
            append contacts reduce [copy n/text copy a/text copy p/text]
            extract-names
        ]
    ]
]
Load a list from file using 'load %filename, and assign it a variable label. Save a list to file using 'save %filename [list]. Create an empty file using save %filename [], only if it doesn't already exist (if the file is not found in the reading of the current directly listing):

Red [needs: 'view]
extract-names: func [] [
    clear names
    foreach [name address phone] contacts [append names name]
    if names = [] [names: [""]]
    copy names
]
if not find read %. %contacts [save %contacts []]
contacts: load %contacts   
names: [""]
names: extract-names
view [
    title "Contacts"
    t: text-list data names [
        n/text: copy pick t/data t/selected
        a/text: copy pick contacts (
            1 + index? find contacts pick t/data t/selected
        )
        p/text: copy pick contacts (
            2 + index? find contacts pick t/data t/selected
        )
    ]
    panel [
        below
        text "Name:"
        n: field 200
        text "Address:"
        a: field 200
        text "Phone:"
        p: field 200
        button "Add" [
            append contacts reduce [copy n/text copy a/text copy p/text]
            extract-names
        ]
        button "Save" [save %contacts contacts]
    ]
]
Notice that a 'title widget with the text "Contacts" was added to the program above, which is displayed in the title bar of the GUI window.

You could create a wide variety of basic "CRUD" (create, read, update, delete) apps using variations of the code above. So far, this program actually only creates and reads, but we'll add more to it shortly.

5. A Few More Complete App Examples
5.1 Tip Calculator
This app calculates the total amount, including tip, to pay for a restaurant meal:

A window layout is created. It contains a title widget, 3 text field widgets, labeled 'f,'t, and 'x, and a button widget. The 'below word is used to position each consecutive widget below one another.
The 'f and 't fields contain some default money and tip rate values ($9 and .2 (20 percent)).
When the button is clicked by the user, the 'x field's text is set to the value computed by multiplying the 'f field's float value, times the 't field's float value + 1 (i.e., the total to pay for a $9 bill is ($9 times 1.2)):
Red [needs: 'view]
view [
    title "Tip Calculator"
    below
    f: field "9"
    t: field ".2" 
    button "Calculate" [
        append clear x/text (to float! f/text) * (1 + (to float! t/text))
    ]
    x: field "tip"
]
5.2 Tile Game
The code below creates a playable tile game. Click any tile piece to move it into the empty space. Rearrange the tiles in ascending order:

A GUI window layout is created with the title "Tile Game" and a silver backdrop color.
The 'style word, in Red's GUI dialect, is used to create a new 'button object labeled 't. Whenever a 't widget is clicked by the user, three actions occur: the label 'x is set to the box's current 'offset (coordinate position), the box's coordinate position is set to the 'e widget's position, and the 'e widget's position is changed to the 'x position. These three actions together effectively swap the positions of the clicked button and the 'e widget (as you'll see below, the widget labeled 'e is just a plain silver base widget (box), which appears as a blank space in the window layout).
The 'return word, in Red's GUI dialect, is used to start a new "line" of widgets (similar to how a carriage return is used to start a new line in a text document).
A bunch of 't box widgets are added to lines in the window layout, along with the final base widget labeled 'e. Any time you click a numbered button, its position is swapped with the empty silver box.
Red [needs: 'view] 
view [ 
     title "Tile Game"
     backdrop silver
     style t: button 100x100 [
         x: face/offset
         face/offset: e/offset 
         e/offset: x
     ] 
     t "8"  t "7"  t "6"  return 
     t "5"  t "4"  t "3"  return 
     t "2"  t" 1"  e: base silver
]
5.3 Generic Calculator
Below is a calculator app. Most of the code should make sense.

A GUI window is created, with the title "Calculator"
The window layout includes a field labeled 'f. It is 230x50 pixels in size, and the font size of text displayed in it is 25.
The 'style word is used to create a new button object called 'b, which is 50x50 pixels in size, and which appends the current button's face text to the 'f field widget's text, whenever one of the 'b buttons is clicked.
A bunch of 'b buttons are added to the window layout, each displaying a different number or mathematical operator. The 'return word is used to start new lines of buttons.
The "=" button attempts to set the 'f field's text to whatever results in "do"ing (evaluating) the current mathematical expression displayed in the 'f field.
Red [needs: 'view]
view [
     title "Calculator"
     f: field 230x50 font-size 25 ""  return 
     style b: button 50x50 [append f/text face/text]
     b "1"  b "2"  b "3"  b " + "  return 
     b "4"  b "5"  b "6"  b " - "  return 
     b "7"  b "8"  b "9"  b " * "  return 
     b "0"  b "."  b " / "  b "=" [attempt [
             calculation: form do f/text 
             append clear f/text calculation
     ]] 
]
NOTE: if you want to work with floats (fractions) in this calculator app, be sure to include a decimal point in at least one of the entered numbers (i.e., 1.0 / 2, instead of 1 / 2)

Try building this same app in any other programming language, and you'll see that there is absolutely nothing simpler than Red's dialect approach to building windowed programs.

5.4 Coin Flip
Clicking the button in this app randomly flips between a heads and tails coin image:

Two images are loaded from specified URLs on the Internet. The label 'h is assigned to the loaded heads image. The label 't is assigned to the loaded tails image.
A window layout is created with the title "Coin Flip" and the 'below layout directive. It contains an image widget labeled 'i which initially displays the 'h image (the coin head image), a text field entry widget labeled 'f, and a button displaying the text "Flip".
When the button is clicked, it sets the 'f field text to the first item in a randomly ordered list of the 2 text strings "Heads" and "Tails".
Next, an 'either conditional evaluation is performed. If the text in the 'f field is "Heads" (that random state was determined in the previous step), then the image value of the 'i widget is set to the 'h image (the heads image). Otherwise (i.e., if the text in the 'f field is "Tails"), then the image in the 'i widget is set to 't (the tails image).
The display (labeled 'g) is updated using the 'show function.
Red [needs: 'view]
h: load http://re-bol.com/heads.jpg
t: load http://re-bol.com/tails.jpg
view [
    title: "Coin Flip"
    below
    i: image h
    f: field
    button "Flip" [
        f/text: first random ["Heads" "Tails"]
        either f/text = "Heads" [i/image: h] [i/image: t] 
    ]
]
NOTE: In this example, the random number generator is not seeded. This tutorial will be updated when that functionality ('random/seed now' in Rebol) is implemented more simply in Red.

5.5 Additional Example Apps to Study
Here are a few more short app examples. See if you can follow the basic flow of code in each program. Pay attention to which pieces of code are variable labels, GUI layout widgets, conditional evaluations, etc.

Here's an app to quiz users on basic addition math facts. Try changing it to quiz subtraction, multiplication, and division on selected ranges of random numbers (i.e., subtraction on numbers 1 - 100 or multiplication on numbers 1 - 12):

Red [needs: 'view]
x: func [] [append append form random 10 " + " form random 20]
view [
    title "Math Test"
    f1: field 
    f2: field "Answer_here..."
    button "Check Answer" [
        print either f2/text = form do f1/text ["Yes!"]["No"]
        f1/text: x
        f2/text: ""
    ]
    do [f1/text: x]
]
Try changing this one to generate insults:

Red [needs: 'view]
xx: form x: ["brilliant" "rare" "unique" "talented" "exceptional"]
yy: form y: ["genius" "champion" "winner" "success" "achiever"]
view [
    title "Compliment Generator"
    below
    area xx
    area yy
    button "Compliment" [
        print [
            "You're a"
            first random x
            first random y "!"
        ]
    ] 
]
More examples are coming soon!

(Be sure to see http://re-bol.com/rebol_quick_start.html and http://re-bol.com/short_rebol_examples.r to see where this tutorial is heading, as Red matures to become as full featured as Rebol 2).

Copyright © 2000-2015 Nick Antonaccio. All rights reserved.
