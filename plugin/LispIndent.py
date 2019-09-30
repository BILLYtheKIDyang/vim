ind_list = {
    '': 1,
    '[': 1,
    'case': 1,
    #    'cond': 1,
    'if': 4,
    'or': 4,
    'and': 5,
}


def ind(buff, stack):
    def char_openp(c):
        return c == "(" or c == "["

    def char_closep(c):
        return c == ")" or c == "]"

    def char_open_or_closep(c):
        return char_openp(c) or char_closep(c)

    def get_token(s, i):
        k = len(s)

        def loop(i):
            if i >= k: return k
            ci = s[i]
            if ci.isspace() or char_open_or_closep(
                    ci) or ci == "'" or ci == '"' or ci == ';':
                return i
            else:
                return loop(i + 1)

        return loop(i + 1)

    in_string = False
    in_block = False
    in_bar = False
    for line in buff:
        k = len(line)

        def char_loop(i):
            nonlocal in_string, in_bar, in_block, stack
            if i < k:
                ci = line[i]
                if ci == ';':
                    if in_string or in_bar or in_block: return char_loop(i + 1)
                    j = i - 1
                    if j >= 0 and line[j] == '#': return char_loop(i + 1)
                    return char_loop(k)
                if ci == '\\': return char_loop(i + 2)
                if ci == '|':
                    if in_bar:
                        in_bar = False
                        return char_loop(i + 1)
                    j = i + 1
                    if in_block and j < k and line[j] == '#':
                        in_block = False
                        return char_loop(i + 2)
                    j = i - 1
                    if j >= 0 and line[j] == '#':
                        in_block = True
                        return char_loop(i + 1)
                    if not (in_string or in_block):
                        in_bar = True
                        return char_loop(i + 1)
                if ci == '"':
                    if in_string:
                        in_string = False
                        return char_loop(i + 1)
                    if not (in_bar or in_block):
                        in_string = True
                        return char_loop(i + 1)
                #if char_openp(ci):
                #    if in_bar or in_string or in_block: return char_loop(i + 1)
                #    p = get_token(line, i)
                #    stack.append((i, line[i + 1:p]))
                #    return char_loop(p)
                if char_openp(ci):
                    if in_bar or in_string or in_block: return char_loop(i + 1)
                    p = get_token(line, i)
                    stack.append((i, line[i + 1:p] if ci == '(' else ''))
                    return char_loop(p)

                if char_closep(ci):
                    if not (in_bar or in_string or in_block):
                        if stack: stack.pop()

                    return char_loop(i + 1)
                return char_loop(i + 1)

        char_loop(0)

    if len(stack) == 0: return 0
    if in_bar or in_string or in_block: return -1

    k = stack[-1][1]
    if k in ind_list:
        return ind_list[k] + stack[-1][0]
    #elif len(k) <= 4:
    #   print(k)
    #   return len(k) + 2 + stack[-1][0]
    else:
        return 2 + stack[-1][0]
