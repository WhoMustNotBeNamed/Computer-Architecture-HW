# Печать содержимого регистра как целого
.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

# Ввод целого числа с консоли в регистр a0
.macro read_int_a0
   li a7, 5
   ecall
.end_macro

# Ввод целого числа с консоли в указанный регистр,
# исключая регистр a0
.macro read_int(%x)
	la  	t1 %x
	push(a0)
	li 	a7, 5
	ecall
	sw 	a0 (t1)
	li	t1 0
	pop	(a0)
.end_macro

# Вывод строки 
.macro print_str(%x)
   .data
str:
   .asciz %x
   .text
   push (a0)
   li a7, 4
   la a0, str
   ecall
   pop	(a0)
.end_macro

# Вывод символа
.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

# Новая строка
.macro newline
   print_char('\n')
.end_macro

# Сохранение заданного регистра на стеке
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

# Выталкивание значения с вершины стека в регистр
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

# Вывод строки из переменной
.macro print_string(%x)
	push(a0)
    	li 	a7, 4
    	la 	a0, %x
    	ecall
    	pop(a0)
.end_macro

# Чтение строки
.macro	read_str(%str, %size)
	la      a0 %str          
	li      a1 %size
	li      a7 8
	ecall
.end_macro

# Чтение размера строки от пользователя
.macro read_size(%x)
	la  	t1 %x
	push(a0)
	li	a7, 5
	ecall
	sw	a0 (t1)
	li	t1 0
	pop(a0)
.end_macro	

# Вызов подпрограммы для копирования строки
.macro strncpy(%res, %str, %size)
	la	a1 %res
	la	a2 %str
	la	a3 %size
	jal	strncpy
.end_macro

# Проверка размеров size
.macro check_size(%x, %size)
	la	t1 %x
	lw	t2 (t1)
	bltz 	t2 err		# x < 0, ошибка
	li	t1 30
	bgt	t2 t1 err	# x > 30, ошибка
	j	exit
err:
	print_str("Размер строки должен быть от 0 до 30!\n")
	j	error		# Читаем размер повторно
exit:
.end_macro

# Завершение программы
.macro exit
    li a7, 10
    ecall
.end_macro
