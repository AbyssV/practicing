import re
from goody import irange
from collections import defaultdict

# Before running the driver on the bsc.txt file, ensure you have put a regular
#   expression pattern in the files repattern1a.txt, repattern1b.txt, and
#   repattern2a.txt. 

def pages (page_spec : str) -> [int]: #result in ascending order (duplicates allowed)
    answer = []
    for ps in page_spec.split(','):
        m = re.match('^([1-9]\d*)(?:([-:])([1-9]\d*))?$', ps)
        assert m != None, 'pages: Illegal specification: '+ps
        p1, sep, p2 = m.group(1,2,3)
        if sep == None:
            answer.append(int(p1))
        else:
            p1, p2 = int(p1), int(p2)
            if sep == '-':
                assert p1 <= p2,'pages: in page sequence {p1}-{p2}, {p1} > {p2}'.format(p1=p1,p2=p2)
                answer += [i for i in irange(p1,p2)]
            else:
                answer += [i for i in irange(p1,p1+p2)]

    return sorted(answer)
            

def multi_search(pat_file : open, text_file : open) -> [(int,str,[int])]:
    pred_list = [(i,re.compile(p.rstrip())) for i,p in enumerate(pat_file,1)]
    result = []
    for num,line in enumerate(text_file,1):
        line = line.rstrip()
        matched = [i for i,p in pred_list if p.search(line)]
        if matched:
            result.append((num,line,matched))
    return result
    
    
if __name__ == '__main__':
    print(multi_search(open("pats.txt"),open("texts.txt")))
    import driver
#     driver.default_show_traceback = True
#     driver.default_show_exception = True
#     driver.default_show_exception_message = True
    driver.driver()
