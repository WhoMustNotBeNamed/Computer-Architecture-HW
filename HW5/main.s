.include "macrolib.s"
.include "input_arr.s"
.include "find_sum.s"

.global main

.text
main:
        print_str ("Enter the number of array elements from 1 to 10: ")
        read_int(t3)
        check_n         # Проверка корректности введенного n

        print_str ("Input numbers: ")
        newline
        input_arr       # Ввод массива
        
        solve
        
        output          # Вывод результата
        newline
        
        exit            # Завершение программы