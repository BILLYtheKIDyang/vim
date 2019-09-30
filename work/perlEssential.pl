( 1, 2, 3); # 列表，列表只返回最后一个元素的值
[1,2,3];    # 匿名数组
# 用列表来初始化数组
@array = (1,2,3);
$array[0];
# 用匿名数组
@array = [1,2,3];
# 匿名数组本身成为数组的第一个元素
$array[0];

# 匿名数组当数组的地道用法是用引用
$ref = [1,2,3];
# 数组引用的访问
@$ref[1];
# 更简洁的用法？？？ 
$ref->[1];

@array = (1,2,3);
$ref   = \@array;
$ref->[0];
@{$ref}[0];

%hash = (
   one   => "uno",
   two   => "dos",
   three => "tres",
   four  => "quatro",
   five  => "cinco"
);
foreach my $k (sort keys %hash) {
   print "$k: $hash{$k}";
}
$ref = {
   one   => "uno",
   two   => "dos",
   three => "tres",
   four  => "quatro",
   five  => "cinco"
};
$ref->{one};

[1,2,3]                              -> [1];
{one => 1, two => 2}                 -> {one};
sub { my($n) = @_; return $n * $n; } -> (2);

$ra = [1,2,3];
$rh = {one => 1, two => 2 };
$rf = sub { my($n) = @_; return $n * $n; };
${$ra}[1];
${$rh}{one};

%hash = ( one => 1, two => 2);
if (exists $hash{three}) {
   "YES";
} else {
   "NO";
}
