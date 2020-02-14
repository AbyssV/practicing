from goody import irange,type_as_str

class Date:
    month_dict = {1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31}

    @staticmethod
    def is_leap_year(year):
        return (year%4 == 0 and year%100 != 0) or year%400 == 0
 
    
    @staticmethod
    def days_in(year,month):
        return Date.month_dict[month] + (1 if month == 2 and Date.is_leap_year(year) else 0)

    
    def __init__(self,year,month,day):
        assert type(year) is int and year >= 0,   'Date.__init__: year('+str(year)+') is not positive'
        assert type(month) is int and 1 <= month <= 12, 'Date.__init__: month('+str(month)+') is not int in range [1,12]'
        assert type(day) is int and 1 <= day <= Date.days_in(year,month), 'Date.__init__: days('+str(day)+') is not correct for month('+str(month)+')/year('+str(year)+')'
        self.year  = year
        self.month = month
        self.day   = day
        # 1<=m<=12 means we can write bool statements together
        

    def __getitem__(self,index):
        if type(index) is not tuple:
            index =(index,)
        if not all(type(i) is str and i in ('y','m','d') for i in index):
            raise IndexError('Date.__getitem__: illegal argument in '+str(index))
        answer = tuple(self.year if i=='y' else self.month if i=='m' else self.day for i in index)
        if len(answer)==1:
            answer = answer[0]
        return answer
        # all(type(i) is str and i in ('y','m','d') for i in index)
        # tuple(self.year if i == 'y' else self.month if i == 'm' else self.day for i in index)
        # inside all can be any iterable

    def __repr__(self):
        return 'Date('+','.join(str(part) for part in self['y','m','d'])+')'
    # join support iterable as well
    
    def __str__(self):
        return str(self.month)+'/'+str(self.day)+'/'+str(self.year)


    def __len__(self):
        # Straightforward but inefficient way to compute len
        days = 0
        for y in range(self.year):
            days += 366 if Date.is_leap_year(y) else 365
        for m in range(1,self.month):
            days += Date.days_in(self.year,m)
        days += self.day-1
        return days
#         # Subtle but efficient way to compute len
#         days = 0
#         # If year != 0, compute # of days elapsed since year 0 (which is a leap year) 
#         if self.year > 0:
#             days += 1 + self.year*365 + (self.year-1)//4  - (self.year-1)//100 + (self.year-1)//400
#         for m in range(1, self.month):
#             days += self.days_in(self.year, m)
#         days += self.day-1
#         return days
    
    
    def __eq__(self,right):
        return type(right) is Date and self['y','m','d'] == right['y','m','d']
    # index support tuple, and tuple can omit parenthesis
    
    
    def __lt__(self,right):
        if type(right) is Date:
            return len(self) < len(right)
        elif type(right) is int:
            return len(self) < right
        else:
            raise TypeError('unorderable types: '+type_as_str(self)+'() < '+type_as_str(right)+')')


    def __add__(self,right):
        if type(right) is not int:
            raise TypeError(' unsupported operand type(s) for +: '+type_as_str(self)+' and '+type_as_str(right))
        y,m,d = self['y','m','d']
        for _i in range(abs(right)):
            if right >= 0:
                d += 1
                if d == Date.days_in(y,m)+1:
                    d,m = 1, m+1
                    if m == 13:
                        m,y = 1,y+1
            else:
                d -= 1
                if d == 0:
                    m -= 1
                    if m == 0:
                        d,m,y = 31,12,y-1
                    else:
                        d = Date.days_in(y,m)
        return Date(y,m,d)
                        
                        
    def __radd__(self,left):
        return self+left
    
    
    def __sub__(self,right):
        if type(right) is Date:
            return len(self)-len(right)
        if type(right) is int:
            return self + -right
        raise TypeError(' unsupported operand type(s) for +: '+type_as_str(self)+' and '+type_as_str(right))
    
                        
    def __call__(self,year,month,day):
        self.__init__(year,month,day)
 
 
        

if __name__ == '__main__':
    # Put in simple tests for Date before allowing driver to run

    print()
    import driver
    
    driver.default_file_name = 'bsc1.txt'
#     driver.default_show_traceback = True
#     driver.default_show_exception = True
#     driver.default_show_exception_message = True
    driver.driver()



        
        
        
        
        
