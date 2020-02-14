from goody import type_as_str
from math import sqrt


class DimensionError(Exception):
    def __init__(self,message=None):
        Exception.__init__(self,message)


class Dimensional:
    def __init__(self,value,l=0,m=0,t=0):
        for d in 'lmt':
            assert type(eval(d)) is int, 'Dimensional.__init: argument l('+str(eval(d))+') must be an int'    
        self.value,   self.l, self.m, self.t = value,   l, m, t


    def __bool__(self):
        return self.value != 0
    
    
    def __len__(self):
        return sum([abs(x) for x in self['d']])
    
    
    def __repr__(self):
        return 'Dimensional('+str(self.value)+\
                             ('' if self.l == 0 else ',l='+str(self.l))+\
                             ('' if self.m == 0 else ',m='+str(self.m))+\
                             ('' if self.t == 0 else ',t='+str(self.t))+')' 


    def __str__(self):
        return str(self.value)+'('+str(self.l)+','+str(self.m)+','+str(self.t)+')'


    def __getitem__(self,arg):
        return (self.l,self.m,self.t) if arg == 'd' else self.__dict__[arg]

    
    def format(self,units):
        def f(c,p):
            return  c if abs(p)==1 else c+'**'+str(abs(p))
        val   = str(self.value)
        num   = ''.join([f(c,p) for c,p in zip(units,self['d']) if p >0])
        denom = ''.join([f(c,p) for c,p in zip(units,self['d']) if p <0])
        return val + (' 1' if num=='' and denom!='' else ' '+num if num!='' else '') + ('' if denom=='' else '/'+denom)
    
    def __pos__(self):
        return self
    
    def __neg__(self):
        return Dimensional(-self.value,*self['d'])
    
    @staticmethod
    def _get_value(arg):
        return arg.value if type(arg) is Dimensional else arg
             
    @staticmethod
    def _get_dims(arg):
        return arg['d'] if type(arg) is Dimensional else (0,0,0)
            
    @staticmethod
    def _validate_addsub(l,r,op):
        Dimensional._validate_relational(l,r,op)
        if type(l) in [int,float] and r['d'] != (0,0,0):
            raise DimensionError('Dimensional: incompatible dimensions for '+op+
                            ': \''+type_as_str(l)+'\' and \''+str(r['d'])+'\'')        
        if type(r) in [int,float] and l['d'] != (0,0,0):
            raise DimensionError('Dimensional: incompatible dimensions for '+op+
                            ': \''+str(l['d'])+'\' and \''+type_as_str(r)+'\'')        

    @staticmethod
    def _validate_muldiv(l,r,op):
        if type(l) not in [int,float,Dimensional] or type(r) not in [int,float,Dimensional]:
            raise TypeError('Dimensional: unsupported operand type(s) for '+op+
                            ': \''+type_as_str(l)+'\' and \''+type_as_str(r)+'\'')        

    @staticmethod
    def _validate_relational(l,r,op):
        Dimensional._validate_muldiv(l,r,op)
        if type(l) is Dimensional and type(r) is Dimensional and l['d'] != r['d']:
            raise DimensionError('Dimensional: incompatible dimensions for '+op+
                            ': \''+str(l['d'])+'\' and \''+str(r['d'])+'\'')
    def __add__(self,right):
        Dimensional._validate_addsub(self,right,'+')
        return Dimensional(self.value + Dimensional._get_value(right),*self['d'])
    
    def __radd__(self,left):
        Dimensional._validate_addsub(left,self,'+')
        return Dimensional(Dimensional._get_value(left) + self.value,*self['d'])

  
    def __sub__(self,right):
        Dimensional._validate_addsub(self,right,'-')
        return Dimensional(self.value - Dimensional._get_value(right),*self['d'])
    
    def __rsub__(self,left):
        Dimensional._validate_addsub(left,self,'-')
        return Dimensional(Dimensional._get_value(left) - self.value,*self['d'])

    def __mul__(self,right):
        Dimensional._validate_muldiv(self,right,'*')
        return Dimensional(self.value * Dimensional._get_value(right),
                           *(x+y for x,y in zip(self['d'],Dimensional._get_dims(right))))
    
    def __rmul__(self,left):
        Dimensional._validate_muldiv(left,self,'*')
        return Dimensional(Dimensional._get_value(left) * self.value,
                           *(x+y for x,y in zip(Dimensional._get_dims(left),self['d'])))

   
    def __truediv__(self,right):
        Dimensional._validate_muldiv(self,right,'/')
        return Dimensional(self.value / Dimensional._get_value(right),
                           *(x-y for x,y in zip(self['d'],Dimensional._get_dims(right))))
    
    def __rtruediv__(self,left):
        Dimensional._validate_muldiv(left,self,'/')
        return Dimensional(Dimensional._get_value(left) / self.value,
                           *(x-y for x,y in zip(Dimensional._get_dims(left),self['d'])))

    def __pow__(self,right):
        if type(right) is int or (type(right) is Dimensional and type(right['value']) is int and right['d'] == (0,0,0)):
#            if Dimensional._get_value(right) > 0:
            return Dimensional(self.value ** Dimensional._get_value(right),
                               *(x * Dimensional._get_value(right) for x in self['d']))
#            else:
#                return 1/Dimensional(self.value ** abs(Dimensional._get_value(right)),
#                                   *(x * abs(Dimensional._get_value(right)) for x in self['d']))
        if type(right) is not Dimensional:
            raise TypeError('Dimensional: unsupported operand type(s) for **'
                            ': \''+type_as_str(self)+'\' and \''+type_as_str(right)+'\'') 
        else:       
            raise DimensionError('Dimensional: incompatible dimensions for ** (2nd operand must be 0,0,0'
                            ': \''+str(self['d'])+'\' and \''+str(right['d'])+'\'')
  
    def __eq__(self,right):
        Dimensional._validate_relational(self,right,'==')
        return Dimensional._get_value(self) == Dimensional._get_value(right)
    
    def __neq__(self,right):
        Dimensional._validate_relational(self,right,'!=')
        return Dimensional._get_value(self) != Dimensional._get_value(right)
    
    def __lt__(self,right):
        Dimensional._validate_relational(self,right,'<')
        return Dimensional._get_value(self) < Dimensional._get_value(right)
    
    def __gt__(self,right):
        Dimensional._validate_relational(self,right,'>')
        return Dimensional._get_value(self) > Dimensional._get_value(right)
    
    def __le__(self,right):
        Dimensional._validate_relational(self,right,'<=')
        return Dimensional._get_value(self) <= Dimensional._get_value(right)
    
    def __ge__(self,right):
        Dimensional._validate_relational(self,right,'>=')
        return Dimensional._get_value(self) >= Dimensional._get_value(right)

    
    # no iadd, isub imul itrudiv ipow


    def __abs__(self):
        return Dimensional(abs(self['value']),*self['d'])
    
    
    def sqrt(self):
        if any([d%2==1 for d in self['d']]):
            raise DimensionError('Dimensional: sqrt: all dimensions must be even: ' +str(self['d']))
        return Dimensional( sqrt(self.value), *[d//2 for d in self['d']])
    
    
    def __setattr__(self,attribute,value):
        assert 't' not in self.__dict__, 'Dimensional.__setattr__ attribute('+str(attribute)+') not allowed to mutate'
        self.__dict__[attribute] = value


if __name__ == '__main__':
    # You can put your own code to test Dimensional here; for example
    t = Dimensional(2.5,t=1)
    g = Dimensional(9.8,l=1,t=-2)
    d = .5*g*t**2
    print(d.format("mgs"))
    
    
    #driver tests
    import driver
    driver.default_file_name = 'bsc2.txt'
#     driver.default_show_exception=True
#     driver.default_show_exception_message=True
#     driver.default_show_traceback=True
    driver.driver()
