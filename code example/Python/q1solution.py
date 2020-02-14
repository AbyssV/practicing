from collections import defaultdict

def palindrome(s : str) -> bool: # Helper function; do not remove or modify
    return s == s[-1::-1]


def abs_of(f : callable) -> callable:
    return lambda x : abs(f(x))


def select(predicates : [callable]) -> callable:
#     # non-lambda solution
#     def filter1(alist):
#         return [x for x in alist if all(p(x) for p in predicates)]
#     return filter1
    return lambda alist : [x for x in alist if all(p(x) for p in predicates)]


# Solution with count_same
# def talk(alist):
#     assert len(alist) >= 1 and all(type(x) is int for x in alist),\
#        'q1solution.talk: alist('+str(alist)+'empty or contains non int values'
#     def count_same(i):
#         count = 1
#         while i+count < len(alist) and alist[i+count] == alist[i]:
#             count += 1
#         return count
#  
#     i = 0
#     answer = []
#     while i < len(alist):
#         count = count_same(i)
#         answer.extend([count,alist[i]])
#         i += count
#     return answer


# Solution with end
# def talk(alist : [int]) -> [int]:
#     assert len(alist) >= 1 and all(type(x) is int for x in alist),\
#        'q1solution.talk: alist('+str(alist)+'empty or contains non int values'
#     def end(i):
#         ei = i
#         while ei < len(alist) and alist[ei] == alist[i]:
#             ei += 1
#         return ei-1
#  
#     i = 0
#     answer = []
#     while i < len(alist):
#         ei = end(i)
#         answer.extend([ei-i+1,alist[i]])
#         i = ei+1
#     return answer
 

# Short solution 
def talk(alist : [int]) -> [int]:
    assert len(alist) >= 1 and all(type(x) is int for x in alist),\
       'q1solution.talk: alist('+str(alist)+'empty or contains non int values'
    answer = []
    start = 0
    for i,v in enumerate(alist):
        if v != alist[start]:
            answer.extend([i-start,alist[start]])
            start = i
    answer.extend([i-start+1,alist[start]])
    return answer


def made_quota(db : {str:(str,int,int)}) -> {str}:
#     # looping statement solution
#     answer = set()
#     for n,cqs in db.items():
#         for _c,q,s, in cqs:
#             if s < q:
#                 break
#         else:
#             answer.add(n)
#     return answer
  
    # looping statement solution
    return {n for n,cqs in db.items() if all(q<=s for _c,q,s, in cqs)}


def sales1(db : {str : (str,int,int)}) -> [str]:
    # looping in comprehension solution
    return sorted(db, key=(lambda n : sum(s for _c,_q,s, in db[n])), reverse=True)


def sales2(db : {str : (str,int,int)}) -> [(str,int)]:
#     # looping statement solution
#     answer = []
#     for n,cqs in db.items():
#         sales = 0
#         for _c,_q,s, in cqs:
#             sales += s
#         answer.append((n,sales))
#     answer.sort(key=(lambda t : (-t[1],t[0])))
#     return answer

    # looping in comprehension solution
    return sorted( ((n,sum(s for c,q,s in cqs)) for n,cqs in db.items()),\
                      key=(lambda t : (-t[1],t[0])))


def by_category(db : {str : (str,int,int)}) -> {str : (str,int,int)}:
    answer = defaultdict(list)
    for n,cqs in db.items():
        for c,q,s in cqs:
            answer[c].append((n,q,s))
    for c,nqs in answer.items():
        nqs.sort()
    return dict(answer)


def category_leaders(db : {str : (str,int,int)}) -> [int,{str}]:
    answer = {}
    for n,pqs in db.items():
        for p,_q,s in pqs:
            if p not in answer or answer[p][0] < s:
                answer[p] = [s,{n}]
            elif answer[p][0] == s:
                answer[p][1].add(n)
    return answer





if __name__ == '__main__':
    from goody import irange
    # Feel free to test other cases as well
    
    print('Testing abs_of')
    f = abs_of(lambda x : 3*x+2)
    print( [(a,f(a)) for a in [-10, -5, 0, 5, 10]] )
    g = abs_of(lambda x : -x)
    print( [(a,f(a)) for a in [-10, -5, 0, 5, 10]] )
     
    print('\nTesting select')
    big_odd = select ([(lambda x : x%2 == 1), (lambda x : x > 5)]) 
    print( big_odd(range(1,10)) )
    scp = select([(lambda x : len(x) <=5),(lambda x : x[0] not in 'aeiou'),palindrome])
    print( scp(['rotator', 'redder', 'pepper', 'rotor', 'tiny', 'eye', 'mom', 'ere', 'radar', 'racecar', 'peep']) )

    print('\nTesting talk')
    seq = [1]
    print(1, seq)
    for i in irange(2,10):
        seq = talk(seq)
        print(i,seq)

    # For testing functions: none should mutate these dicts
    lexus = {'Rich': {('car', 10, 4), ('suv', 10, 12)},
             'Steve': {('crossover', 10, 12), ('car', 7, 8)},
             'Nancy': {('truck', 10, 5), ('car', 10, 8)},
             'Lori' : { ('suv', 10, 12), ('truck', 10, 10), ('car', 10, 15) } }
    
    ace =   {'Alex'  : {('hammer', 4, 7), ('saw', 6, 6)},
             'Mark'  : {('hammer', 6, 8), ('wrench', 7, 6)},
             'Bernie': {('pliers', 4, 5), ('screws', 4, 2)},
             'Mike'  : { ('pliers', 2, 3), ('screws', 4, 4), ('wrench', 3, 3) },
             'Katie' : { ('hammer', 1, 1), ('pliers', 2, 6), ('screws', 3, 5) } }

    ace2 =  {'Alex'  : {('hammer', 4, 6), ('saw', 6, 6)},
             'Mark'  : {('hammer', 6, 8), ('wrench', 7, 6)},
             'Bernie': {('pliers', 4, 5), ('screws', 4, 7)},
             'Mike'  : { ('pliers', 2, 5), ('screws', 4, 4), ('wrench', 3, 3) },
             'Katie' : { ('hammer', 1, 1), ('pliers', 2, 6), ('screws', 3, 5) } }
    
    print('\nTesting made_quota')
    print(made_quota(lexus))
    print(made_quota(ace))
    
    print('\nTesting sales1')
    print(sales1(lexus))
    print(sales1(ace))
    
    print('\nTesting sales2') 
    print(sales2(lexus))
    print(sales2(ace))
    print(sales2(ace2))
    
    print('\nTesting by_category')
    print(by_category(lexus))
    print(by_category(ace))

    print('\nTesting category_leader')
    print(category_leaders(lexus))
    print(category_leaders(ace))

    
    print('\ndriver testing with batch_self_check:')
    import driver
#     driver.default_show_traceback = True
#     driver.default_show_exception = True
#     driver.default_show_exception_message = True
    driver.driver()           





























