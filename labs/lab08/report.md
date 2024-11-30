---
## Front matter
title: "Лабораторная работа №8"
subtitle: "Программирование цикла.
 Обработка аргументов командной строки."
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

Целью работы является приобретение навыков написания программ с использованием циклов и обработкой
аргументов командной строки.

# Выполнение лабораторной работы
Создала и перешла в директорию для лабораторной работы создала файл lab7-8.asm (рис. [-@fig:001]).

![Папка для лабораторной работы](image/1.png){#fig:001 width=70%}

Переписала код с лабараторной работы(рис. [-@fig:002]).

![Листинг кода](image/2.png){#fig:002 width=70%}

Листинг кода:

```
;-----------------------------------------------------------------
; Программа вывода значений регистра 'ecx'
;-----------------------------------------------------------------


%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите N: ',0h

SECTION .bss
    N: resb 10

SECTION .text
    global _start
_start:

; ----- Вывод сообщения 'Введите N: '
    mov eax,msg1
    call sprint

; ----- Ввод 'N'
    mov ecx, N
    mov edx, 10
    call sread

; ----- Преобразование 'N' из символа в число
    mov eax,N
    call atoi
    mov [N],eax

; ------ Организация цикла
    mov ecx,[N] ; Счетчик цикла, `ecx=N`
    
label:
    mov [N],ecx
    mov eax,[N]
    call iprintLF   ; Вывод значения `N`
    loop label      ; `ecx=ecx-1` и если `ecx` не '0'
                    ; переход на `label`
    call quit
```

Создала исполняемый файл и запустила его. (рис. [-@fig:003]).

![Результат выполнения](image/3.png){#fig:003 width=70%}	

Заменила часть кода на другой из лабараторной работы.

Листинг кода:

```
; Программа вывода значений регистра 'ecx'
;-----------------------------------------------------------------


%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите N: ',0h

SECTION .bss
    N: resb 10

SECTION .text
    global _start
_start:

; ----- Вывод сообщения 'Введите N: '
    mov eax,msg1
    call sprint

; ----- Ввод 'N'
    mov ecx, N
    mov edx, 10
    call sread

; ----- Преобразование 'N' из символа в число
    mov eax,N
    call atoi
    mov [N],eax

; ------ Организация цикла
    mov ecx,[N]  ; Счетчик цикла, `ecx=N`
label:
 sub ecx,1
 mov [N],ecx
 mov eax,[N]
 call iprintLF
 loop label
    ; переход на `label`

    call quit
```

Создала исполняемый файл и запустила его. Созданный цикл не принимает всех ожидаемых значений, кол-во проходов отличается от заданного в аргументе. (рис. [-@fig:004]).

![Результат выполнения](image/4.png){#fig:004 width=70%}

Добавила изменение значение регистра ecx в цикле.
 
Листинг кода:

```
;-----------------------------------------------------------------
; Программа вывода значений регистра 'ecx'
;-----------------------------------------------------------------


%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите N: ',0h

SECTION .bss
    N: resb 10

SECTION .text
    global _start
_start:

; ----- Вывод сообщения 'Введите N: '
    mov eax,msg1
    call sprint

; ----- Ввод 'N'
    mov ecx, N
    mov edx, 10
    call sread

; ----- Преобразование 'N' из символа в число
    mov eax,N
    call atoi
    mov [N],eax

; ------ Организация цикла
    mov ecx,[N] ; Счетчик цикла, `ecx=N`
label:
	push ecx ; добавление значения ecx в стек
	sub ecx,1
	mov [N],ecx
	mov eax,[N]
	call iprintLF
	pop ecx ; извлечение значения ecx из стека
	loop label
    ; переход на `label`
    
    call quit
```

Создала исполняемый файл и запустила его. Теперь регистр принимает значения с на еденицу меньше значения аргумента и до 0. Число проходов цикла соответствует введенному с клавиатуры. (рис. [-@fig:005]).

![Результат выполнения](image/5.png){#fig:005 width=70%}

Создала новый файл и переписала в него код из лабараторной работы. ( рис. [-@fig:006]).

![Листинг кода](image/6.png){#fig:006 width=70%}

Листинг кода 8.2:

```
;-----------------------------------------------------------------
; Обработка аргументов командной строки
;-----------------------------------------------------------------

%include 'in_out.asm'
SECTION .text
global _start

_start:
	pop ecx         ; Извлекаем из стека в `ecx` количество
		            ; аргументов (первое значение в стеке)
	pop edx         ; Извлекаем из стека в `edx` имя программы
		            ; (второе значение в стеке)
	sub ecx, 1      ; Уменьшаем `ecx` на 1 (количество
                    ; аргументов без названия программы)
next:
    cmp ecx, 0      ; проверяем, есть ли еще аргументы
    jz _end         ; если аргументов нет выходим из цикла
                    ; (переход на метку `_end`)
    pop eax         ; иначе извлекаем аргумент из стека
    call sprintLF   ; вызываем функцию печати
    loop next       ; переход к обработке следующего
                    ; аргумента (переход на метку `next`)
_end:
    call quit
```

Создала исполняемый файл и запустила его. Программой было отработано 4 аргумента (рис. [-@fig:007]).

![Результат выполнения](image/7.png){#fig:007 width=70%}

Создала новый файл и переписала в него код из лабараторной работы. рис. [-@fig:008]).

![Листинг кода](image/8.png){#fig:008 width=70%}

Листинг кода 8.3:

```
%include 'in_out.asm'

SECTION .data
msg db "Результат: ",0

SECTION .text
global _start

_start:
    pop ecx         ; Извлекаем из стека в `ecx` количество
                    ; аргументов (первое значение в стеке)
    pop edx         ; Извлекаем из стека в `edx` имя программы
                    ; (второе значение в стеке)
    sub ecx,1 ; Уменьшаем `ecx` на 1 (количество
                    ; аргументов без названия программы)
    mov esi, 0      ; Используем `esi` для хранения
                    ; промежуточных сумм
next:
    cmp ecx,0h      ; проверяем, есть ли еще аргументы
    jz _end         ; если аргументов нет выходим из цикла
                    ; (переход на метку `_end`)
    pop eax         ; иначе извлекаем следующий аргумент из стека
    call atoi       ; преобразуем символ в число
    add esi,eax     ; добавляем к промежуточной сумме
                    ; след. аргумент `esi=esi+eax`
    loop next       ; переход к обработке следующего аргумента
    
_end:
    mov eax, msg    ; вывод сообщения "Результат: "
    call sprint
    mov eax, esi    ; записываем сумму в регистр `eax`
    call iprintLF   ; печать результата
    call quit       ; завершение программы
```

Создала исполняемый файл и запустила его. Проверила с несколькими введенными числыми. (рис. [-@fig:009]).

![Результат работы](image/9.png){#fig:009 width=70%}

# Выполнение самостоятельной работы

Написала программу, которая выполняет вычисления для 10 варианта задания f(x)=5(2+x) (рис. [-@fig:010]).

![Листинг кода](image/10.png){#fig:010 width=70%}

Запустила программу, и проверила работу с различными аргументами (рис. [-@fig:011]).

Листинг кода самостоятельной работы:

```
%include 'in_out.asm'

SECTION .data
msg db "Результат: ",0
formula db "Формула:  f(x)=5(2+x)",0

SECTION .text
global _start

_start:
    pop ecx         ; Извлекаем из стека в `ecx` количество
                    ; аргументов (первое значение в стеке)
    pop edx         ; Извлекаем из стека в `edx` имя программы
                    ; (второе значение в стеке)
    sub ecx,1 	    ; Уменьшаем `ecx` на 1 (количество
                    ; аргументов без названия программы)
    mov esi, 0      ; Используем `esi` для хранения
                    ; промежуточных сумм
next:
    cmp ecx,0h      ; проверяем, есть ли еще аргументы
    jz _end         ; если аргументов нет выходим из цикла
                    ; (переход на метку `_end`)
    pop eax         ; иначе извлекаем следующий аргумент из стека
    call atoi       ; преобразуем символ в число
    add eax, 2      ; Прибавляем 2
    mov ebx, 5		; ebx = 5
    mul ebx         ; Умножаем на 5
    add esi,eax     ; добавляем к промежуточной сумме
                    ; след. аргумент `esi=esi+eax`
    loop next       ; переход к обработке следующего аргумента
    
_end:
	mov eax, formula; вывод сообщения "Формула: "
    call sprintLF
    mov eax, msg    ; вывод сообщения "Результат: "
    call sprint
    mov eax, esi    ; записываем сумму в регистр `eax`
    call iprintLF   ; печать результата
    call quit       ; завершение программы
```

![Результат работы](image/11.png){#fig:011 width=70%}

# Выводы
Выполнив данную лабараторную работу, я обрела навыки написания программ с использованием циклов и обработкой
аргументов командной строки.
