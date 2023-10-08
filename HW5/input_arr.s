.global input_arr

input_arr:
.data
	.align  2                                               # Выравнивание на границу слова
	n:              .word	0                               # Число введенных элементов массива
	array:          .space  64                              # 64 байта
	sep:            .asciz  "--------\n"                    # Строка-разделитель (с \n и нулём в конце)
.text
        la      t0 array        # Указатель элемента массива     
input:	li      a7 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv      t2 a0           # Сохраняем результат в t2	        
        sw      t2 (t0)         # Запись числа по адресу в t0
        addi    t0 t0 4         # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 input        # Если осталось больше 0
        la      a0 sep          # Выведем строку-разделитель
        li      a7 4            # Системный вызов №4
        ecall
        ret                     # Возврат к основной программе 