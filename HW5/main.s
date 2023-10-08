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
    input_arr		# Ввод массива
    
    solve
    
    print_str ("sum = ")
    print_int(t6)	# Вывод суммы
    newline
    
    print_str ("number of iterations = ")
    print_int(s1)	# Вывод количества просуммированных элементов
    newline
    
    print_str ("number of even = ")
    print_int(s5)	# Вывод количества четных элементов
    newline
    
    print_str ("number of odd = ")
    print_int(s6)	# Вывод количества нечетных элементов
    newline
    
    exit            # Завершение программы
