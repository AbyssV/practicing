/*
    ICS 51. Lab #3

    IMPORTATNT NOTES:

    - This lab has five parts. The description of each part is given below.

    - Noramally, the compiler adds the prologue/epilogue code for the callee. However, when the 
    __declspec(naked) attribute is used, it is the programmer's responsibility to write the 
    prologue/epilogue code. In this lab you need to write prologue/epilogue code sections only 
    for the functions that have been declared with the naked attribute, namely:

       + findMinIndex
       + isPalindrome
       + performOperation
       + gcd

    - You cannot define any local variable in the C code. If you need additional variables in your
    assembly code, you have to allocate space for them in the prologue of the function. 

    - You are not allowed to change anything in this file except for adding your assembly code 
    between the lines marked "BEGIN YOUR CODE HERE" and "END YOUR CODE HERE".

    - Remember to fill in your name, student ID below.

    - ONLY submit the lab3.c file for grading.

*/

char *yourName = "Yating Liu";
char *yourStudentID = "10588498";


/***********************************************************************************************

    PART 1: Change Letter Case

    You are given a string (null-terminated array of characters) that may contain numbers,
    upper andlower case letters, punctuations symbols, etc. Implement a function to convert all
    uppercase letters to lowercase and vice versa.
    For example "ThisIsTheFinalLabOf51" should be converted to "tHISiStHEfINALlABoF51".
    The string should be modifed in place. There is no explicit output for this function.

    Tips:

    - Note that each element of the arrays is a char (1 byte). You can NOT use a 32-bit register
    to read/write from/to a memory location. Instead you should use the 8-bit version of the x86
    general-purpose registers.

    - The link to the ASCII codes is here: http://www.asciitable.com/

************************************************************************************************/

void changeCase(char *string) {

    __asm{
        // BEGIN YOUR CODE HERE
		mov esi, 0 //character counter
		mov eax, string //base address
	begin_of_loop:
		mov bl, byte ptr[eax+esi]
		cmp bl, 0x00
		je end_of_loop //null terminate
		cmp bl, 0x41
		jl next_character
		cmp bl, 0x5A
		jg lower_case
		add bl, 0x20
		mov byte ptr[eax+esi], bl
		jmp next_character

	lower_case:
		cmp bl, 0x61
		jl next_character
		cmp bl, 0x7A
		jg next_character
		sub bl, 0x20
		mov byte ptr[eax+esi], bl

	next_character:
		inc esi
		jmp begin_of_loop

	end_of_loop:


        // END YOUR CODE HERE
    }
}

/***********************************************************************************************

    PART 2: Selection Sort

    Selection sort is an in-place comparison sort algorithm that works by dividing the input list 
    into two parts: the sublist of items already sorted, which is built up from left to right of 
    the list, and the sublist of items remaining to be sorted that occupy the rest of the list. 
    Initially, the sorted sublist is empty and the unsorted sublist is the entire input list. 
    The algorithm proceeds by finding the smallest element in the unsorted sublist, exchanging it 
    with the leftmost unsorted element (putting it in sorted order), and moving the sublist 
    boundaries one element to the right. To learn more, read: 
    https://en.wikipedia.org/wiki/Selection_sort#Example

    Our implementation here uses a function called "findMinIndex" to find the index of smallest
    element between ith index and jth index of the array. The function "selectionSort" uses
    this function to find the smallest number and exchanges it with the leftmost unsorted element
    in each iteration. You need to implement the behavior of both functions in x86 assembly.

************************************************************************************************/

__declspec(naked) 
int findMinIndex (int integer_array[], int i, int j)
{

// C code to be converted to x86 assembly
/*
    int iMin = i;
    // test against elements after i and before j to find the smallest 
    for ( i ; i < j; i++) {
        // if this element is less, then it is the new minimum   
        if (integer_array[i] < integer_array[iMin]) {
            // found new minimum; remember its index 
            iMin = i;
        }
    }

    return iMin;
*/

    __asm{
            mov eax, 0
            // BEGIN YOUR CODE HERE
			push ebp
			mov ebp, esp
			push edi
			push esi
			push ebx

			mov eax, [ebp+8] //array_integer
			mov esi, [ebp+12] //i
			mov edi, [ebp+16] //j

			mov ecx, esi //min index
			mov ebx, dword ptr[eax+esi*4] //min value
	
		begin_loop:
			cmp esi, edi
			jg end_loop
			mov edx, dword ptr[eax+esi*4]
			cmp edx, ebx
			jge next_iter
			mov ecx, esi //update min index
			mov ebx, edx //update min value
		
		next_iter:
			inc esi
			jmp begin_loop


		end_loop:
			mov eax, ecx
			pop ebx
			pop esi
			pop edi			
			pop ebp

            // END YOUR CODE HERE
            ret
    }

}

void selectionSort (int integer_array[], int array_size)
{

// C code to be converted to x86 assembly
/*  
    int j;
    int iMin;
    int temp;

    // advance the position through the entire array //
    // (could do j < n-1 because single element is also min element) //
    for (j = 0; j < array_size-1; j++) {

        // find the index of min element in the unsorted a[j .. n-1] //
        iMin = findMinIndex (integer_array, j, array_size);
 
        if(iMin != j) { // swap values
            temp = integer_array[iMin];
            integer_array[iMin] = integer_array [j];
            integer_array[j] = temp;    
        }
    }
*/

    __asm{
            // BEGIN YOUR CODE HERE
			mov eax, integer_array
			mov ebx, array_size
			mov esi, 0 //j
			mov edi, 0
			dec ebx //array_size-1
	
		begin_loop:
			cmp esi, ebx
			jg end_loop
			push eax
			push ecx
			push edx

			push ebx //j
			push esi  //i
			push eax //integer_array
			call findMinIndex
			add esp, 12
			mov edi, eax

			pop edx
			pop ecx
			pop eax

			//swap value
			cmp edi, esi//edi is the min index, esi is current index
			je next_iter
		
			mov edx, dword ptr[eax+edi*4]//min value
			mov ecx, dword ptr[eax+esi*4]//current value
			mov dword ptr[eax+edi*4], ecx
			mov dword ptr[eax+esi*4], edx

		next_iter:
			inc esi
			jmp begin_loop
	
		end_loop:


            // END YOUR CODE HERE
    }

}

/***********************************************************************************************

    PART 3: Palindrome

    Given a string, complete the implementation of the recursive function isPalindrome() to check 
    if the string is palindrome or not. A string is said to be palindrome if reverse of the 
    string is same as string. For example, “abba?is palindrome, but “abbc?is not palindrome.

************************************************************************************************/

__declspec(naked)
int isPalindrome(char *input_string, int left_index, int right_index)
{

// C code to be converted to x86 assembly
/*
    // Input Validation
    if (NULL == input_string || left_index < 0 || right_index < 0){
        return -1;
    }
    // Recursion termination condition
    if (left_index >= right_index)
        return 1;
    if (input_string[left_index] == input_string[right_index]){
        return isPalindrome(input_string, left_index + 1, right_index - 1);
    }
    return -1;
*/

    __asm{
            mov eax, 0
            // BEGIN YOUR CODE HERE
			push ebp
			mov ebp, esp
			push edi
			push esi
			push ebx

			mov ebx, dword ptr[ebp+8] //input_string
			mov esi, dword ptr[ebp+12]  //left_index
			mov edi, dword ptr[ebp+16] //right_index
			//test for input validation		
			cmp ebx, 0x00
			je invalid
			cmp esi, 0
			jl invalid
			cmp edi, 0
			jl invalid
			//test for same value
			mov al, byte ptr[ebx + esi]
			mov dl, byte ptr[ebx + edi]
			cmp al, dl
			jne invalid
			cmp esi, edi	
			jge ret_1
				
			inc esi //left index+=1
			dec edi //right index-=1
			
			push edi
			push esi
			push ebx
			
			call isPalindrome	
			
			add esp, 12
			jmp end
		
		invalid:
			mov eax, -1
			jmp end
		
		ret_1:
			mov eax, 1

		end:
			pop ebx
			pop esi
			pop edi

			mov esp, ebp
			pop ebp
            // END YOUR CODE HERE
            ret
	

    }
}

/***********************************************************************************************

    PART 4: Vector Operation

    The vectorOperations function gets as parameters 4 arrays of the same length and
    the number of elements in those arrays. 

    For each pair of elements in first_array and second_array, it calls performOperation
    and stores the returned result in the same index of output_array.

    output_array[index] = performOperation(operation_array[index], first_array[index], second_array[index]).

    You also need to implement the body of performOperation function according to the provided
    C code.
  
************************************************************************************************/

__declspec(naked) 
int performOperation (int operation, int first, int second)
{

// C code to be converted to x86 assembly
/*
    if (operation==0) 
        return first - second;
    else if (operation==1)
        return first + second;
    else if (operation==2)
        return (first < second)? first : second;
    else if (operation==3)
        return (first > second)? first : second;
    else
        return first;
*/

    __asm {
            // BEGIN YOUR CODE HERE
			push ebp
			mov ebp, esp
			push edi
			push esi
			push ebx

			mov eax, [ebp+8] //operation
			mov esi, [ebp+12] //first
			mov edi, [ebp+16] //second

			cmp eax, 0
			je is_zero
			cmp eax, 1
			je is_one
			cmp eax, 2
			je is_two
			cmp eax, 3
			je is_three
			mov eax, esi
			jmp end
			
		is_zero:
			mov ecx, esi
			sub ecx, edi
			mov eax, ecx
			jmp end

		is_one:
			mov ecx, esi
			add ecx, edi
			mov eax, ecx
			jmp end

		is_two:
			cmp esi, edi
			jl return_first
			mov eax, edi
			jmp end

		is_three:
			cmp esi, edi
			jg return_first
			mov eax, edi
			jmp end

		return_first:
			mov eax, esi

		end:
			pop ebx
			pop esi
			pop edi
			mov esp, ebp
			pop ebp
	
            // END YOUR CODE HERE
            ret
    }
  
}

void vectorOperations (int number_of_elements, int *first_array, int *second_array, 
                       int *operation_array, int *output_array)
{
// C code to be converted to x86 assembly
/*
    int i;
    for (i=0; i<number_of_elements; i++)
    {
        output_array[i] = performOperation(operation_array[i], first_array[i], second_array[i]);
    }
*/

    __asm {
            // BEGIN YOUR CODE HERE
			mov esi, 0
			mov edi, number_of_elements

		begin_of_loop:
			cmp esi, edi
			jge end_of_loop
			mov eax, first_array
			mov ebx, second_array
			mov ecx, operation_array
			mov ecx, dword ptr[ecx+4*esi] //operation_array[i]
			mov eax, dword ptr[eax+4*esi] //first_array[i]
			mov ebx, dword ptr[ebx+4*esi] //second_array[i]

			push eax
			push ecx
			push edx

			push ebx
			push eax
			push ecx
			call performOperation
			add esp, 12
			mov ebx, eax
			
			pop edx
			pop ecx
			pop eax

			mov edx, output_array
			mov dword ptr[edx+4*esi], ebx

			inc esi
			jmp begin_of_loop

		end_of_loop:


            // END YOUR CODE HERE
    }
}

/***********************************************************************************************

    PART 5: Dijkstra's Algorithm to calculate GCD.

    Implement a recursive function in assembly that calculates the greatest common divisor of 
    two unsigned integers.

    Given two unsigned integers n and m, we can define GCD(m , n) as:

           GCD(m , n) = n                       ,    if (m % n) == 0
           GCD(m , n) = GCD(n , m % n)          ,    if (m % n) >  0

************************************************************************************************/

__declspec(naked) 
unsigned int gcd(unsigned int m, unsigned int n) {

// C code to be converted to x86 assembly
/*
    if ((m % n) == 0)
        return n;
    else
        return gcd(n, m % n);
*/
    __asm{
            mov eax, 0
            // BEGIN YOUR CODE HERE
			push ebp
			mov ebp, esp

			push edi
			push esi
			push ebx

			mov esi, dword ptr[ebp+8] //m
			mov edi, dword ptr[ebp+12] //n
			mov edx, 0
			mov eax, esi
			mov ebx, edi
			div ebx
			cmp edx, 0
			je ret_1

			push ecx
			push edx
			mov esi, edi //m=n
			mov edi, edx //m%n
			push edi
			push esi
			
			call gcd
			add esp, 8
		
			pop ecx
			pop edx
			jmp end
		ret_1:
			mov eax, edi
		end:
			pop ebx
			pop esi
			pop edi
			mov esp, ebp
			pop ebp

            // END YOUR CODE HERE
            ret
    }
}