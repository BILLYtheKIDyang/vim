if (0) {
   $scalar; # 单个值
   $array[3]; # 数组的元素
   $hash{'key'}; # 哈希表的元素

   @array; # 数组
   @array[0,2,6]; # 数组的切片
   @hash{qw(key1 key2)}; # 哈希表的切片

   %hash; # 哈希表
   &function; # 函数
   *symbolist; # 符号表
}
# 七个名字空间
# 标量
$a = 1;
# 数组
@a = (1, 2, 3);
# 散列
%a = (a => 1, b => 2);
print foreach $a;
print foreach @a;
print foreach %a;

*$a;
{
   package foo;
   $a = 'foo::a';
   *$a
}

$a = 1;
@a = (1, 2, 3);
%a = (a => 97, b => 98);
$a[3] = 4;  # 看见方括号，是对数组的操作
$a{c} = 99; # 看见花括号，是对散列的操作
$a = 2;     # 没有，是对标量的操作

# 字符串比较
'a' lt 'b';
'a' eq 'A';
"joseph" eq "joseph ";
# 数值比较
0 < 5;
10 == 10.0;
'10' gt '2';
"10.0" eq "10"; # 按字串比较是不同的
'abc' == 'def'; # 按数值比较是相同的

123 ~~ 123;
123 ~~ '456';
'123.0' ~~ 123;
'Mini' ~~ 'Mini';
'123' ~~ '123.0';

# 整数0，字符串'0'，undef，空字符串''为假，其余为真。


undef @a; while (defined(my $file = glob('*.pl'))) {
  push @a,  $file;
}
[@a];

while (<STDIN>) {
   print;
}

while (defined(my $line = <STDIN>)) {
   print;
}   

@cats = qw(Buster Roscoe Mimi);
$favorite = $cats[8];
$cats[1] = undef;
print foreach @cats;

foreach my $cat (@cats) {
   next unless defined $cat;
   print "I have a cat named $cat\n";
}
$#cats;
for (my $i = 0; $i <= $#cats; $i += 1) {
   next unless defined $cats[$i];
   print "I hava a cat named $cats[$i]\n";
}

%hash;
$hash{foo};         # 0
print defined $hash{foo}; # 
exists $hash{foo};
$hash{foo} = undef;
