from pathlib import Path
import sys
import re

def check_path(file_name):
    p=Path(file_name)
    if p.is_dir():
        return p
    else:
        print('输入的目录名不正确')
        return

def walk(root, rl, f):
    fl = len(re.split('[\\\\/]', str(root))) - rl
    for file in root.iterdir():
        if file.suffix!='.sdr':
            if file.is_dir():
                for i in range(fl):
                    print('    ', end='')
                    f.write('    ')
                print("------------------ {} 级目录 [{}]------------------".format(fl, file.name))
                f.write("------------------ {} 级目录 [{}]------------------\n".format(fl, file.name))
                walk(file, rl, f)
            elif file.is_file():
                for i in range(fl-1):
                    print('    ', end='')
                    f.write('    ')
                print('- ', file.stem)
                f.write('- ' + str(file.stem) + '\n')
    return

def dire(root, f):
    for file in root.iterdir():
        if file.is_file():
            name = str(file.stem)
            name = re.sub('_.+','',name)
            print('- ', name)
            f.write('- ' + name + '\n')

if __name__ == '__main__':
    try:
        file_name = sys.argv[1]
        root = check_path(file_name)
        flag = sys.argv[2]
        if flag == '-b':
            with open('购买的书籍.txt','a+',encoding='utf-8') as f:
                f.write("购买的书籍\n")
                dire(root, f)
        elif flag == '-i':
            rl = len(str(root).split('\\'))
            with open('下载的书籍.txt','w+',encoding='utf-8') as f:
                f.write("目录{}下的书籍\n".format(file_name))
                walk(root, rl, f)
        else:
            print('仅支持-b和-i')
    except:
        print('命令输入不正确')

