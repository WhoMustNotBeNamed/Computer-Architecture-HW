.include "macrolib.s"

.global main

main:
.eqv	SIZE 30	    # Буфер

.data	
	.align 2							                    # Выравнивание ячеек
	test1_empty_str:	.asciz  ""			                # Тест 1, пустая строка
	test2_str:		    .asciz  "Hello world and RISC-V!"	# Тест 2, строка
	test3_user_str:	    .space  SIZE				        # Тест 3, пользовательская строка
	user_size:		    .word  0				            # Длина строки от пользователя 	
	TEST1_SIZE_10:	    .word  10				            # Буфер на 10 байт
	TEST2_SIZE_20:	    .word  20				            # Буфер на 20 байт
	TEST3_SIZE_30:	    .word  30				            # Буфер на 30 байт
	result1:		    .space SIZE				            # Ответ1
	result2:		    .space SIZE				            # Ответ2
	result3:		    .space SIZE				            # Ответ3
	result4:		    .space SIZE				            # Ответ4
	result5:		    .space SIZE				            # Ответ5

.text
	print_str("Первый тест - пустая строка\n")
	strncpy(result1, test1_empty_str, TEST3_SIZE_30)
	print_str("Результат: ")
	print_string(result1)
	
	print_str("\n________________________________\n")
	newline
	
	print_str("Второй тест - копируем 10 байт\n")
	strncpy(result2, test2_str, TEST1_SIZE_10)
	print_str("Результат: ")
	print_string(result2)
	
	print_str("\n________________________________\n")
	newline
	
	print_str("Третий тест - копируем 20 байт\n")
	strncpy(result3, test2_str, TEST2_SIZE_20)
	print_str("Результат: ")
	print_string(result3)
	
	print_str("\n________________________________\n")
	newline
	
	print_str("Четвертый тест - копируем всю строку\n")
	strncpy(result4, test2_str, TEST3_SIZE_30)
	print_str("Результат: ")
	print_string(result4)
	
	print_str("\n________________________________\n")
	newline
	
	print_str("Пятый тест - читаем строку пользователя\n")
	print_str("Введите строку: ")
	read_str(test3_user_str, SIZE)
error:	print_str("Введите количество байт, которое хотите скопировать (от 0 до 30): ")
	read_size(user_size)
	check_size(user_size, SIZE)
	strncpy(result5, test3_user_str, user_size)
	print_str("Результат: ")
	print_string(result5)
	
	exit