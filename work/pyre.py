import re
text = "a猪哥b最帅c"
re.findall('abc', 'abcdefgabcdeefg')
re.findall('abc', 'ABCDEFGABCDEEFG', re.IGNORECASE)
re.findall(r'\w+', text, re.ASCII)
re.findall('.*', '两\n行')
re.findall('.*', '两\n行', re.DOTALL)
re.findall('^最帅', '猪哥\n最帅')
re.findall('^最帅', '猪哥\n最帅', re.MULTILINE)
re.findall(r'''^猪哥 # 人物
               最帅 # 描述
                ''', '猪哥最帅')
re.findall(r'''^猪哥 # 人物
               最帅 # 描述
                ''', '猪哥最帅', re.VERBOSE)

re.findall('最帅', '诸葛最帅', re.DEBUG)

re.match
re.search
re.fullmatch
re.findall
re.finditer
re.split
re.sub
re.subn
re.compile
re.escape
re.purge

