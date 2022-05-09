name "CA_PROJECT_1232B_BATTIKH_ALA_EDDINE"

include 'emu8086.inc'  

org 100h 


    ;printn 'show menu' 
    
game proc;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;WELCOME
    welcome:
        call clear_screen
        call dln
        call game_title
        call dln                              
        call intro
        call active
        
            
;MAIN-------------------------------------------------
    main:
        call clear_screen          
        call dln
        printn 'MENU'
        
    main_menu:
        call dln     
        print 'Info [i]   Play [p]   Exit [Esc] '   
        call get_char
        
        cmp al, 'i'
        jz info
        cmp al, 'p'
        jz game_starts
                
        cmp al, 'I'        
        jz info        
        cmp al, 'P'        
        jz game_starts        

        cmp al, 27  ; Dec ascii for esc key
        jz exit
        
     main_menu_error:
        call dln
        call error
        jmp main_menu

;INFO------------------------------------------------- 
    info:
        call clear_screen        
        call infop
        jmp info_menu     
    info_menu:
        call dln
        print 'Menu [m]   Exit [Esc] '
        call get_char
        
        cmp al, 'm'        
        jz main
        
        cmp al, 'M'        
        jz main
        
    info_error:
        call dln
        call error
        jmp info_menu
                
;START-------------------------------------------------
    game_starts:
        call clear_screen
        call dln
        printn 'THE GAME STARTS NOW!' 
        call active
        
        call clear_screen
        call dln
        call instruction_1
        call active
        
    pick_number:    
        call clear_screen
        call dln 
        call instruction_2
        call get_char
        mov bl, al
        
        call clear_screen
        call dln
        call instruction_3
        
    guess_loop:
        call get_char
        cmp al,bl
        jz win
        jg call higher
        jl call lower

        
    win:
        printn ' CORRECT! PLAYER 2 WINS!'
        jmp restart
        
            
;RESTART-----------------------------------------------
    restart:
        call dln
        print 'would you like to restart? [y/n] '
        call get_char
        
        cmp al, 'y'
        jz pick_number
        cmp al, 'Y'
        jz pick_number
        
        cmp al, 'n'
        jz main
        cmp al, 'N'
        jz main
        
        jmp error
                
    restat_error:
        call dln            
        call error
        jmp restart 
       
;EXIT-------------------------------------------------    
    exit:
        call dln
        printn 'see you next time!'
        mov ah, 4ch
        int 21h
    
game endp;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;////\\\\////\\\\////\\\\ TITLE ////\\\\////\\\\////\\\\ 
game_title proc
    printn '+-------------------------------------------+'
    printn '|1234567890<<<GUESS THE NUMBER>>>0987654321 |'
    printn '+-------------------------------------------+'
    ret
game_title endp

;////\\\\////\\\\////\\\\ WELCOME ////\\\\////\\\\////\\\\ 
intro proc
    printn 'WELCOME! '
    ret
intro endp

;////\\\\////\\\\////\\\\ INFO DESCRIPTION ////\\\\////\\\\////\\\\ 
infop proc
    printn ''
    printn 'the game consists of two participants.'
    printn ''
    printn 'the first participant is the one starting,'
    printn '' 
    printn 'he must pick a random number from 0 to 9.'
    printn ''
    printn 'The second participant have to guess it.'
    ret
infop endp

;////\\\\////\\\\////\\\\ GAME INSTRUCTIONS ////\\\\////\\\\////\\\\ 
instruction_1 proc
    printn 'PLAYER 1: choose one number between 0 and 9. '
    printn ''
    printn '          But make sure PLAYER 2 is not seeing it.'
    call dln
    printn 'PLAYER 2: leave PLAYER 1 some space :)'
    ret
instruction_1 endp

instruction_2 proc
    print 'PLAYER 1: enter your number: ' 
    ret    
instruction_2 endp

instruction_3 proc
    printn 'PLAYER 1: your number is now hidden, ' 
    printn ''
    printn '          you can invite PLAYER 2 back'
    call dln
    printn 'PLAYER 2: now is your turn,'
    printn ''
    print '          can you guess the number? '    
    ret    
instruction_3 endp

;////\\\\////\\\\////\\\\ PRESS ANY KEY ////\\\\////\\\\////\\\\ ; anti-unactivity
active proc
    call dln
    print 'press any key to continue '
    call get_char
    ret
active endp

;////\\\\////\\\\////\\\\ Lower Number ////\\\\////\\\\////\\\\
lower proc
    printn ' incorrect, try a higher number '
    jmp guess_loop
    printn ''
    ret
lower endp

;////\\\\////\\\\////\\\\ Higher Number ////\\\\////\\\\////\\\\
higher proc
    printn ' incorrect, try a lower number '
    jmp guess_loop
    printn ''
    ret
higher endp

;////\\\\////\\\\////\\\\ ERROR ////\\\\////\\\\////\\\\ ; in case inputted char doesn't match with the existing options
error proc
    call dln
    printn 'unvalid option...'
error endp

;////\\\\////\\\\////\\\\ TWO LINES ////\\\\////\\\\////\\\\ ; make text more visual by adding more space between lines
dln proc
    printn ''
    printn ''
    ret
dln endp
        
;////\\\\////\\\\////\\\\ Get a Character ////\\\\////\\\\////\\\\ ; to get one char
get_char proc
    mov ah,01h
    int 21h
    ret
get_char endp

DEFINE_GET_STRING       
DEFINE_PRINT_STRING  
DEFINE_CLEAR_SCREEN   

end
