.global find_sum

find_sum:
.data
        error1:         .asciz  "incorrect n!\n"                # Сообщение о некорректном вводе
        error2:         .asciz 	"overflow!"                     # Сообщение о переполнении
        line_break:     .asciz 	"\n"                            # Перенос строки
.text
	lw      t3 n                # Число элементов массива
        la      t0 array            # Указатель элемента массива
        li      t2, 0               # Обнуление 0    
        li      s3, 2               # s3 = 2
solve:  lw      t5 (t0)        	    # Вытаскиваем элемент массива и кладем его в t5
        bgtz    s7, even_odd        # Если у нас произошло переполнение, то переменная больше 0 и мы не считаем сумму    
        add 	t2 t2 t5            # Складываем t5, t6 и сохраняем в t2			
	
        bltz 	t5 check1           # if t5 < 0
back1:	bgtz	t5 check2           # if t5 > 0
back2:	
        mv      t6 t2               # Сохраняем сумму в t6    
        addi    s1 s1 1	            # Количество итераций
	
even_odd:
        remu    s4 t5 s3            # Вычисление остатка при деления на 2
    	beqz    s4 even             # if s4 == 0, то число четное
    	bnez    s4, odd             # if s4 != 0, то число нечетное
back3:                              # Сохраняем сумму в t6
        addi    t0 t0 4             # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1            # Уменьшим количество оставшихся элементов на 1    	
        bnez    t3 solve            # Если осталось больше 0	
        
        ret                         # Возврат к основной программе 
        
check1: bgtz 	t6 back1     		# if t6 > 0
        bgt 	t2 t6 out_error		# if t2 > t6
        j       back1   
	
check2: bltz 	t6 back2     		# if t6 < 0
        blt	t2 t6 out_error		# if t2 < t6
        j       back2

out_error:    
        la      a0 error2               # Сообщение об ошибке
        li      a7 4                    # Системный вызов №4
        ecall	
        la      a0 line_break           # Перенос строки
        li      a7 4                    # Системный вызов №4
        ecall
        addi    s7 s7 1                 # Увеличиваем s7
        j       solve	         

even:	addi	s5  s5 1		# Увеличиваем счетчик четного
        j       back3
odd:	addi 	s6  s6 1		# Увеличиваем счетчик нечетного
        j       back3