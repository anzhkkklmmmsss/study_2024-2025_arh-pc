---
## Front matter
title: "Лабораторная работа №9"
subtitle: "Понятие подпрограммы.
Отладчик GDB."
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

Целью работы является приобретение навыков написания программ с использованием подпрограмм. Знакомство
с методами отладки при помощи GDB и его основными возможностями.

# Выполнение лабораторной работы
Создала и перешла в директорию для лабораторной работы создала файл lab9-1.asm (рис. [-@fig:001]).

![Папка для лабораторной работы](image/1.png){#fig:001 width=70%}

Переписала код с лабараторной работы(рис. [-@fig:002]).

![Листинг кода](image/2.png){#fig:002 width=70%}

Листинг кода:

```
%include 'in_out.asm'
SECTION .data
    msg: DB 'Введите x: ',0
    result: DB '2x+7=',0
SECTION .bss
    x: RESB 80
    res: RESB 80
SECTION .text
GLOBAL _start
    _start:

;------------------------------------------
; Основная программа
;------------------------------------------

    mov eax, msg
    call sprint

    mov ecx, x
    mov edx, 80
    call sread

    mov eax,x
    call atoi

    call _calcul        ; Вызов подпрограммы _calcul

    mov eax,result
    call sprint
    mov eax,[res]
    call iprintLF

    call quit
    
;------------------------------------------
; Подпрограмма вычисления
; выражения "2x+7"

_calcul:
    mov ebx,2
    mul ebx
    add eax,7
    mov [res],eax
ret ; выход из подпрограммы
```

Создала исполняемый файл и запустила его. (рис. [-@fig:003]).

![Результат выполнения](image/3.png){#fig:003 width=70%}	

Создала файл lab09-2.asm с кодом из лабараторной работы.(Программа печати
сообщения Hello world!)

Листинг кода:

```
SECTION .data
        msg1: db "Hello, ",0x0
        msg1Len: equ $ - msg1
        msg2: db "world!",0xa
        msg2Len: equ $ - msg2
SECTION .text
        global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1Len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2Len
    int 0x80
    mov eax, 1
    mov ebx, 0
    int 0x80
```

Получила исполняемый файл. Для работы с GDB добавила в исполняемый файл отладочную информацию, трансляцией с ключом ‘-g’. Загрузила исполняемый файл в отладчике gdb. (рис. [-@fig:004]).

![Отладчике gdb](image/4.png){#fig:004 width=70%}

Проверила работу программы, запустив ее в оболочке GDB с помощью команды run. (рис. [-@fig:005]).

![Результат выполнения](image/5.png){#fig:005 width=70%}

Для более подробного анализа программы установила брейкпоинт на метку _start, с
которой начинается выполнение любой ассемблерной программы, и запустила её. ( рис. [-@fig:006]).

![Добавление брейкпоинта](image/6.png){#fig:006 width=70%}

Посмотрела дисассимилированный код программы с помощью команды disassemble
начиная с метки _start (рис. [-@fig:007]).

![Дисассимилированный код](image/7.png){#fig:007 width=70%}

Переключитесь на отображение команд с Intel’овским синтаксисом, введя команду set
disassembly-flavor intel рис. [-@fig:008]).

![Отображение команд с Intel’овским синтаксисом](image/8.png){#fig:008 width=70%}

Различие отображения синтаксиса машинных команд в режимах ATT и Intel
состоит в том, что менется положение название регистраи его значения.
Включила режим псевдографики для более удобного анализа программы (рис. [-@fig:009]).

![Результат работы](image/9.png){#fig:009 width=70%}

Установила еще одну точку остановки по адресу инструкции. 
Для этого определила адрес предпоследней инструкции (mov ebx,0x0) и установила точку остановки.
Посмотрела информацию о всех установленных брейкпоинтах. (рис. [-@fig:010], рис. [-@fig:011], рис. [-@fig:012]).

![Адрес предпоследней инструкции](image/10.png){#fig:010 width=70%}

![Установка брейкпоинта](image/11.png){#fig:011 width=70%}

![Информация о брейпоинтах](image/12.png){#fig:012 width=70%}

Выполнила 5 инструкций с помощью команды si и проследите за изменением
значений регистров. Значения регистров eax и eip (рис. [-@fig:013]).

![Информация о брейпоинтах](image/13.png){#fig:013 width=70%}

Посмотрела значения переменных msg1 и msg2 по имени (рис. [-@fig:014]).

![Значение переменных msg1 и msg2 ](image/14.png){#fig:014 width=70%}

Изменила первый символ переменной msg1 (рис. [-@fig:015]).

![Переменная msg1](image/15.png){#fig:015 width=70%}

Изменила первый символ переменной msg2 (рис. [-@fig:016]).

![Переменная msg2](image/16.png){#fig:016 width=70%}

С помощью команды set изменила значение регистра ebx (рис. [-@fig:017]).

![Значение регистра ebx](image/17.png){#fig:017 width=70%}

Завершила выполнение программы с помощью команды continue и выйшла из GDB с помощью команды quit (рис. [-@fig:018]).

![Завершение работы](image/18.png){#fig:018 width=70%}

Скопировала файл lab8-2.asm, созданный при выполнении лабораторной работы №8,
с программой выводящей на экран аргументы командной строки в файл с
именем lab09-3.asm. 
Создала исполняемый файл и загрузила в gdb программу с аргументами и ключом --args. (рис. [-@fig:019]).

![lab09-3.asm](image/19.png){#fig:019 width=70%}

Установила точку останова перед первой инструкцией в программе и запустила
ее (рис. [-@fig:020]).

![Информация о брейпоинтах](image/20.png){#fig:020 width=70%}

Посмотрела позиции стека, в которых распологаются аргументы программы (рис. [-@fig:021]).

![Позиции стека и аргументы](image/21.png){#fig:021 width=70%}

# Выполнение самостоятельной работы

Преобразовала программу из лабораторной работы №8 (Задание №1 для самостоятель-
ной работы), реализовав вычисление значения функции f(x)=5(2+x) как подпрограмму. (рис. [-@fig:022]).

![Выполнение программы](image/22.png){#fig:022 width=70%}

Листинг кода:

```
%include 'in_out.asm'

SECTION .data
    msg db "Результат: ",0
    formula db "Формула:  f(x)=5(2+x)",0

SECTION .bss
    res: RESB 80

SECTION .text
global _start

_start:
    pop ecx         ; Извлекаем из стека в `ecx` количество
                    ; аргументов (первое значение в стеке)
    pop edx         ; Извлекаем из стека в `edx` имя программы
                    ; (второе значение в стеке)
    sub ecx,1 	    ; Уменьшаем `ecx` на 1 (количество
                    ; аргументов без названия программы)
next:
    cmp ecx,0h      ; проверяем, есть ли еще аргументы
    jz _end         ; если аргументов нет выходим из цикла
                    ; (переход на метку `_end`)
    pop eax         ; иначе извлекаем следующий аргумент из стека
    call atoi       ; преобразуем символ в число
    
    call _calcul
    add [res],eax     ; добавляем к промежуточной сумме
                    ; след. аргумент `esi=esi+eax`
    loop next       ; переход к обработке следующего аргумента
    
_end:
    mov eax, formula; вывод сообщения "Формула: "
    call sprintLF
    mov eax, msg    ; вывод сообщения "Результат: "
    call sprint
    mov eax, [res]    ; записываем сумму в регистр `eax`
    call iprintLF   ; печать результата
    
    call quit       ; завершение программы
    
;------------------------------------------
; Подпрограмма вычисления
; функции "f(x)=5(2+x)"

_calcul:
    add eax, 2      ; Прибавляем 2
    mov ebx, 5		; ebx = 5
    mul ebx         ; Умножаем на 5
    ret
```

Проверила, что программа при запуске дает неверный результат (рис. [-@fig:023])

![Выполнение программы](image/23.png){#fig:023 width=70%}

С помощью отладчика GDB, анализируя изменения значений регистров, определила ошибку и исправила ее (рис. [-@fig:024])

![Отладчика GDB](image/24.png){#fig:024 width=70%}

Листинг кода(исправленный):

```
%include 'in_out.asm'
    SECTION .data
    div: DB 'Результат: ',0
    
    SECTION .text
    GLOBAL _start
    _start:
    
    ; ---- Вычисление выражения (3+2)*4+5
        mov ebx,3
        mov eax,2
        add eax,ebx
        mov ecx,4
        mul ecx
        add eax,5
        mov edi,eax
        
    ; ---- Вывод результата на экран
    mov eax,div
    call sprint
    mov eax,edi
    call iprintLF
    call quit
```

Проверила корректность исполнения программы (рис. [-@fig:025])

![Выполнение программы](image/25.png){#fig:025 width=70%}


# Выводы
Выполнив данную лабараторную работу, я обрела навыки написания программ с использованием подпрограмм. И ознакомилась с методами отладки при помощи GDB и его основными возможностями.
