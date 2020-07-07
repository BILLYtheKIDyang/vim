bob = ['Bob Smith', 42, 30000, 'software']
sue = ['Sue Jones', 45, 40000, 'hardware']
bob[0], sue[2]     # 获取姓名，薪水
bob[0].split()[-1] # Bob 姓什么
sue[2] *= 1.25     # 给 sue 加薪 25%
sue

people = [bob, sue]
for person in people: # 引用列表的列表
    print(person)

people[1][0]

for person in people:
    print(person[0].split()[-1])
    person[2] *= 1.20

for person in people:
    print(person[2])

pays = [person[2] for person in people]
pays

pays = map((lambda x: x[2]), people)
list(pays)
list(pays)

sum(person[2] for person in people)

people.append(['Tom', 50, 0, None])
len(people)
people[-1][0]

NAME, AGE, PAY = range(3)
bob = ['Bob Smith', 42, 10000]
bob[NAME]
PAY, bob[PAY]

bob = [['name', 'Bob Smith'], ['age', 42], ['pay', 10000]]
sue = [['name', 'Sue Jones'], ['age', 45], ['pay', 20000]]
people = [bob, sue]

for person in people:
    print(person[0][1], person[2][1])

[person[0][1] for person in people]

for person in people:
    print(person[0][1].split()[-1])
    person[2][1] *= 1.10

for person in people:
    print(person[2])

for person in people:
    for (name, value) in person:
        if name == 'name': print(value)

def field(record, label):
    for (fname, fvalue) in record:
        if fname == label:
            return fvalue

field(bob, 'name')
field(sue, 'pay')

for rec in people:
    print(field(rec, 'age'))

bob = {'name': 'Bob Smith', 'age': 42, 'pay': 30000, 'job': 'dev'}
sue = {'name': 'Sue Jones', 'age': 45, 'pay': 40000, 'job': 'hdw'}

bob['name'], sue['pay']
bob['name'].split()[-1]
sue['pay'] *= 1.10
sue['pay']

bob = dict(name='Bob Smith', age=42, pay=30000, job='dev')
sue = dict(name='Sue Jones', age=45, pay=40000, job='hdw')
bob
sue

sue = {}
sue['name'] = 'Sue Jones'
sue['age'] = 45
sue['pay'] = 40000
sue['job'] = 'hdw'
sue

names = ['name', 'age', 'pay', 'job']
values = ['Sue Jones', 45, 40000, 'hdw']
list(zip(names, values))
sue = dict(zip(names, values))
sue

fields = ('name', 'age', 'job', 'pay')
record = dict.fromkeys(fields, '?')
record

people = [bob, sue]
for person in people:
    print(person['name'], person['pay'], sep=', ')

for person in people:
    if person['name'] == 'Sue Jones':
        print(person['pay'])

# P40


'spam eggs ham'[5:10]
'spam ' + 'eggs ham'
'spam %s %s' % ('eggs', 'ham')
'spam {} {}'.format('eggs', 'ham')
'spam = "%-5s", %+06d' % ('ham', 99)
'spam = "{0:<5}", {1:+06}'.format('ham', 99)
str=""
str.find
str.replace
str.split
str.join
str.strip
str.rstrip
str.rjust
str.upper
str.isupper
str.isdigit
str.endswith
str.startswith

template = '---$target1---$target2---'
val1 = 'Spam'
val2 = 'shrubbery'
template = template.replace('$target1', val1)
template = template.replace('$target2', val2)
template

template = '''
---
---%(key1)s---
---%(key2)s---
'''
vals = {}
vals['key1'] = 'Spam'
vals['key2'] = 'shrubbery'
print(template % vals)

vals
import string
template = string.Template('---$key1---$key2---')
template.substitute(vals)
template.substitute(key1='Brian', key2='Loretta')
