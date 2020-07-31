| 语法                       | 含义                       |
| :---                       | :---                       |
| $SPAM                      | 获取环境变量SPAM           |
| ${...}                     | 获取整个环境               |
| \${'SP'+'AM'}              | 从表达式中获取环境变量     |
| \$ARG0, \$ARG1, ... $ARG9  | 脚本命令行在下标n处的参数  |
| $ARGS                      | 所有命令行参数的列表       |

| 语法       | 含义                    |
| :---       | :---                    |
| \$()       | 获取输出，返回标准输出  |
| !()        | 获取输出，返回命令管道  |
| $[]        | 传递输出，返回 None     |
| ![]        | 传递输出，返回命令管道  |
| @()        | 嵌入Python代码运算      |
| @$()       | 执行python代码并拆分    |
| \|         | shell风格管道           |
| and, or    | 逻辑组合运算，惰性      |
| &&, \|\|   | 同上                    |
| COMMAND &  | 后台命令                |


| 语法                                                                  | 含义        |
| :---                                                                  | :---        |
| >                                                                     | 写入        |
| >>                                                                    | 加入        |
| <                                                                     | 输入重定向  |
| out, o, err, e, all, a                                                |             |
| >>> COMMAND1 e>o < input.txt \| COMMAND2 > output.txt e>> errors.txt  |             |

| 语法                                                     | 含义  |
| :---                                                     | :---  |
| for x in range(3): <br>&ensp;&ensp;&ensp;&ensp;print(x)  | 循环  |
| for x in range(3): <br>&ensp;&ensp;&ensp;&ensp;print(x)  | 循环  |


<table border="0.1">
   <thead>
      <tr>
         <th style="text-align:left">语法</th>
         <th style="text-align:left">意义</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td style="text-align:left">
            <pre>
for i in range(10):
    print(i)
            </pre>
         </td>
         <td style="text-align:left">好东西</td>
      </tr>
      <tr>
         <td style="text-align:left">
            <pre>
def fact(n):
    if n < 2:
        return 1
    else:
        return n * fact(n - 1)
            </pre>
         </td>
         <td style="text-align:left">好东西</td>
      </tr>
   </tbody>
</table>
