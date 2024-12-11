---
## Front matter
title: "Лабораторная работа №7"
subtitle: "Команды безусловного и условного переходов в Nasm. Программирование ветвлений."
author: "Тютрюмова Анжелина"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Целью работы является приобретение практических навыков работы и изучение команд условного и безусловного переходов. Приобретение навыков написания программ с использованием переходов. А так же знакомство с назначением и структурой файла листинга.

# Выполнение лабораторной работы
Создала и перешла в директорию и создала файл для лабораторной работы(рис. [-@fig:001]).

![Директория lab07](image/1.png){#fig:001 width=70%}

Переписала код с лабараторной работы (рис. [-@fig:002]).

![Листинг кода](image/2.png){#fig:002 width=70%}

Листинг кода:

```
%include 'in_out.asm' ; подключение внешнего файла

 SECTION .data
 msg1: DB 'Сообщение № 1',0
 msg2: DB 'Сообщение № 2',0
 msg3: DB 'Сообщение № 3',0
 SECTION .text
 GLOBAL _start
  _start:

  jmp _label2

  _label1:
    mov eax, msg1 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 1'

   _label2:
    mov eax, msg2 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 2'

   _label3:
    mov eax, msg3 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 3'

   _end:
    call quit ; вызов подпрограммы завершения
```

Создала и запустила исполняемый файл (рис. [-@fig:003]).

![Результат выполнения программы](image/3.png){#fig:003 width=70%}	

Переписала код в файле с лабараторной работы (рис. [-@fig:004]).

![Обновленный код](image/4.png){#fig:004 width=70%}

Листинг кода:

```
%include 'in_out.asm' ; подключение внешнего файла

 SECTION .data
 msg1: DB 'Сообщение № 1',0
 msg2: DB 'Сообщение № 2',0
 msg3: DB 'Сообщение № 3',0
 SECTION .text
 GLOBAL _start
  _start:

  jmp _label2

  _label1:
    mov eax, msg1 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 1'
    jmp _end

   _label2:
    mov eax, msg2 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 2'
    jmp _label2

   _label3:
    mov eax, msg3 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 3'

   _end:
    call quit ; вызов подпрограммы завершения
```

Создала и запустила исполняемый файл. (рис. [-@fig:005]).

![Результат выполнения программы](image/5.png){#fig:005 width=70%}

Переписала код так, что бы он выводил сообщения в порядке 3 2 1 (рис. [-@fig:006]).

![Листинг кода](image/6.png){#fig:006 width=70%}

Листинг кода:

```

 SECTION .data
 msg1: DB 'Сообщение № 1',0
 msg2: DB 'Сообщение № 2',0
 msg3: DB 'Сообщение № 3',0
 SECTION .text
 GLOBAL _start
  _start:

  jmp _label3

  _label1:
    mov eax, msg1 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 1'
    jmp _end

   _label2:
    mov eax, msg2 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 2'
    jmp _label1

   _label3:
    mov eax, msg3 ; Вывод на экран строки
    call sprintLF ; 'Сообщение № 3'
    jmp _label2

   _end:
    call quit ; вызов подпрограммы завершения
```

Создала и запустила исполняемый файл. (рис. [-@fig:007]).

![Результат выполнения программы](image/7.png){#fig:007 width=70%}

Переписала в него код с лабараторной работы в новый файл (рис. [-@fig:008]).

![Листинг кода](image/8.png){#fig:008 width=70%}

Листинг кода

```
%include 'in_out.asm'
section .data
    msg1 db 'Введите B: ',0h
    msg2 db "Наибольшее число: ",0h
	A dd '20'
	C dd '50'
section .bss
	max resb 10
	B resb 10
section .text
global _start
_start:
; ---------- Вывод сообщения 'Введите B: '
	mov eax,msg1
	call sprint
; ---------- Ввод 'B'
	mov ecx,B
	mov edx,10
	call sread
; ---------- Преобразование 'B' из символа в число
	mov eax,B
	call atoi ; Вызов подпрограммы перевода символа в число
	mov [B],eax ; запись преобразованного числа в 'B'
; ---------- Записываем 'A' в переменную 'max'
	mov ecx,[A] ; 'ecx = A'
	mov [max],ecx ; 'max = A'
; ---------- Сравниваем 'A' и 'С' (как символы)
	cmp ecx,[C] ; Сравниваем 'A' и 'С'
	jg check_B ; если 'A>C', то переход на метку 'check_B',
	mov ecx,[C] ; иначе 'ecx = C'
	mov [max],ecx ; 'max = C'
; ---------- Преобразование 'max(A,C)' из символа в число
check_B:
	mov eax,max
	call atoi ; Вызов подпрограммы перевода символа в число
	mov [max],eax ; запись преобразованного числа в `max`
; ---------- Сравниваем 'max(A,C)' и 'B' (как числа)
	mov ecx,[max]
	cmp ecx,[B] ; Сравниваем 'max(A,C)' и 'B'
	jg fin ; если 'max(A,C)>B', то переход на 'fin',
	;mov ecx,[B] ; иначе 'ecx = B'
	mov [max],ecx
; ---------- Вывод результата
fin:
	mov eax, msg2
	call sprint ; Вывод сообщения 'Наибольшее число: '
	mov eax,[max]
	call iprintLF ; Вывод 'max(A,B,C)'
	call quit ; Выход
```

Создала и запустила исполняемый файл. Проверила работу несколькими разными числами (рис. [-@fig:009]).

![Результат выполнения программы](image/9.png){#fig:009 width=70%}

Создала листинг кода lab7-2.lst при помощи команды nasm. помимо основной программы помимо листинга основной программы выше находиться код из in_out.asm (рис. [-@fig:010]).

![Листинг кода](image/10.png){#fig:010 width=70%}

Выбрала набор команд в которой есть несколько операнд (рис. [-@fig:011]).

![Листинг кода](image/11.png){#fig:011 width=70%}

Удалила один из операндов (рис. [-@fig:012]).

![Обновленный листинг](image/12.png){#fig:012 width=70%}

Создала исполняемый файл и запустила его (рис. [-@fig:013]).

![Результат выполнения программы](image/13.png){#fig:013 width=70%}

При создании появились объектный, исполняемый и файл листинга (рис. [-@fig:014]).

![Созданные файлы](image/14.png){#fig:014 width=70%}

# Выполнение самостоятельной работы

Создала и написала код в файле `lab7-3.asm` для нахождения наименьшего из 3 целочисленных переменных а,b среди введенных чисел, соответсвующих варианту 8.  (рис. [-@fig:015]).

![Листинг кода](image/15.png){#fig:015 width=70%}

Листинг кода

```
%include 'in_out.asm'

section .data
    ;msg1 db 'Введите B: ',0h
    msg2 db "Наименьшее число: ",0h
	A dd 41
	C dd 62
	B dd 35
section .bss
	min resb 10
section .text
global _start
_start:
; ---------- Записываем 'A' в переменную 'min'
	mov ecx,[A] ; 'ecx = A'
	mov [min],ecx ; 'min = A'
; ---------- Сравниваем 'A' и 'С' (как символы)
	cmp [C],ecx ; Сравниваем 'A' и 'С'
	jg check_B ; если 'A<C', то переход на метку 'check_B',
	mov ecx,[C] ; иначе 'ecx = C'
	mov [min],ecx ; 'max = C
; ---------- Преобразование 'max(A,C)' из символа в число
check_B:
	mov eax,min
	;call atoi ; Вызов подпрограммы перевода символа в число
	mov [min],eax ; запись преобразованного числа в `min`
; ---------- Сравниваем 'min(A,C)' и 'B' (как числа)
	mov ecx,[min]
	cmp [B],ecx ; Сравниваем 'max(A,C)' и 'B'
	jg fin ; если 'min(A,C)<B', то переход на 'fin',
	mov ecx,[B] ; иначе 'ecx = B'
	mov [min],ecx
; ---------- Вывод результата
fin:
	mov eax, msg2
	call sprint ; Вывод сообщения 'Наименьшее число: '
	mov eax,[min]
	call iprintLF ; Вывод 'min(A,B,C)'
	call quit ; Выход
```
	
Создала исполняемый файл и запустил его. Результат выполнения программы совпадает с ожиданием. (рис. [-@fig:016]).

![Результат выполнения программы](image/16.png){#fig:016 width=70%}

Написала программу для подсчета результата функции f(x) в соответствии с 10 вариантом (рис. [-@fig:017]).

![Листинг кода](image/17.png){#fig:017 width=70%}

Листинг кода:

```
%include 'in_out.asm'

section .data
    msg1 db 'Введите A: ',0h
	msg2 db 'Введите x: ',0h
	msg_res db 'Результат: ',0h

section .bss
	res resb 10
	A resb 10
	x resb 10
section .text
global _start
_start:

; ---------- Вывод сообщения 'Введите A: '
mov eax,msg1
call sprint
; ---------- Ввод 'A'
mov ecx,A
mov edx,10
call sread
; ---------- Преобразование 'A' из символа в число
mov eax,A
call atoi ; Вызов подпрограммы перевода символа в число
mov [A],eax ; запись преобразованного числа в 'A'

; ---------- Вывод сообщения 'Введите B: '
mov eax,msg2
call sprint
; ---------- Ввод 'x'
mov ecx,x
mov edx,10
call sread
; ---------- Преобразование 'x' из символа в число
mov eax,x
call atoi ; Вызов подпрограммы перевода символа в число
mov [x],eax ; запись преобразованного числа в 'x'

; ---------- Сравниваем 'A' и 2

mov ecx, 2
cmp ecx,[x] ; Сравниваем 'X' и 2
jg check_B ; если 'A>2', то переход на метку 'check_B',
mov eax,[A] ; иначе 'f = ax'
mov ecx, 3
mul ecx
mov [res], eax
jmp fin

; ---------- Вычитание '2 из X' 
check_B:
mov eax, [A]
sub eax, 2
mov [res], eax
jmp fin

; ---------- Вывод результата
fin:
mov eax, msg_res
call sprint ; Вывод сообщения 'Результат: '
mov eax,[res]
call iprintLF ; Вывод 'f(x)='
call quit ; Выход
```

Создала и запустила исполняемый файл. Результат совпадает с ответом, полученнымм аналитическим путем. (рис. [-@fig:018]).

![Результат выполнения программы](image/18.png){#fig:018 width=70%}


# Выводы
Выполнив данную лабараторную работу, я обрела практические навыки работы и изучение команд условного и безусловного переходов. Приобретение навыков написания программ с использованием переходов. А так же знакомство с назначением и структурой файла листинга.
