import os, sys
from PIL import Image


def splitimage(src, rownum, colnum, dstpath):
    img = Image.open(src)
    w, h = img.size
    if rownum <= h and colnum <= w:
        print('Original image info: %s, %s x %s, %s, %s' %
              (src, w, h, img.format, img.mode))
        s = os.path.split(src)
        if dstpath == '':
            dstpath = s[0]
        fn = s[1].split('.')
        basename = fn[0]
        ext = fn[-1]

        num = 0
        rowheight = h // rownum
        colwidth = w // colnum
        for r in range(rownum):
            for c in range(colnum):
                box = (c * colwidth, r * rowheight, (c + 1) * colwidth,
                       (r + 1) * rowheight)
                img.crop(box).save(
                    os.path.join(dstpath,
                                 basename + '_' + str(num) + '.' + ext) )
                num = num + 1

        print('图片切割完毕，共生成 %s 张小图片。' % num)
    else:
        print('不合法的行列切割参数！')


if __name__ == '__main__':
    if len(sys.argv) != 5:
        print("%s %s %s row col" % (sys.argv[0], "src", "dst"))
        exit(1)
    src = sys.argv[1]
    dst = sys.argv[2]
    row = int(sys.argv[3])
    col = int(sys.argv[4])
    splitimage(src, row, col, dst)
