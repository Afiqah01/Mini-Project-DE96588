#include<p18F4550.inc>
	
loop_cnt1	set	0x00
loop_cnt2	set 0x01
LCDCONT		equ	PORTC
RS			equ	RC4
RW			equ	RC5
EN			equ RC6

			org	0x00
			goto start
			org	0x08
			retfie
			org	0x18
			retfie
		

dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm
;-------Main Program-----------	
start		MOVLW	B'00001110'
			MOVWF	TRISC, A
			CLRF	TRISC, A
			CLRF	TRISD, A
			CLRF	TRISB, A	
			CLRF	PORTD, A
			CALL	First

CHECK		BTFSC	PORTC,0, A
			BRA		MyName
			CLRF	PORTD, A
CHECK1		BTFSC	PORTC,1, A
			BRA 	MyID
			CLRF	PORTD, A
			BRA		CHECK
			
CHECK2		CALL	Keypad
			BRA		CHECK

;----------Keypad Subroutine----
Keypad		CALL	Second
			CALL	Keypadin
			
ZERO_0		CALL	OUTD
			BTFSS	PORTB,1, A
			BRA		ONE_1
			CALL	SHOW0

ONE_1		CALL	OUTA
			BTFSS	PORTB,0, A
			BRA		TWO_2
			CALL	SHOW1
			
TWO_2		CALL	OUTA
			BTFSS	PORTB,1, A
			BRA		THREE_3
			CALL	SHOW2

THREE_3		CALL	OUTA
			BTFSS	PORTB,2, A
			BRA		FOUR_4
			CALL	SHOW3

FOUR_4		CALL	OUTB
			BTFSS	PORTB,0, A
			BRA		FIVE_5
			CALL	SHOW4

FIVE_5		CALL	OUTB
			BTFSS	PORTB,1, A
			BRA		SIX_6
			CALL	SHOW5

SIX_6		CALL	OUTB
			BTFSS	PORTB,2, A
			BRA		SEVEN_7
			CALL	SHOW6

SEVEN_7		CALL	OUTC
			BTFSS	PORTB,0, A
			BRA		EIGHT_8
			CALL	SHOW7

EIGHT_8		CALL	OUTC
			BTFSS	PORTB,1, A
			BRA		NINE_9
			CALL	SHOW8

NINE_9		CALL	OUTC
			BTFSS	PORTB,2, A
			BRA		STAR
			CALL	SHOW9

STAR		CALL	OUTD
			BTFSS	PORTB,0,A
			BRA		HASTAG
			CALL	SHOWSTAR

HASTAG		CALL	OUTD
			BTFSS	PORTB,2, A
			BRA		HASTAG
			CALL	SHOWHASTAG

			
;---------- keypad Input------
Keypadin	MOVLW	B'00001110'
			MOVWF	TRISB, A
			RETURN
;----------Keypad Output------
OUTA		BSF		PORTB,3, A
			BCF		PORTB,4, A
			BCF		PORTB,5, A
			BCF		PORTB,6, A

OUTB		BCF		PORTB,3, A
			BSF		PORTB,4, A
			BCF		PORTB,5, A
			BCF		PORTB,6, A
			
OUTC		BCF		PORTB,3, A
			BCF		PORTB,4, A
			BSF		PORTB,5, A
			BCF		PORTB,6, A

OUTD		BCF		PORTB,3, A
			BCF		PORTB,4, A
			BCF		PORTB,5, A
			BSF		PORTB,6, A
	

;-----------Subroutine for Myname----
		
MyName		MOVLW	D'65'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'70'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'73'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'81'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'65'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'72'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	0x01
			MOVWF	PORTD, A

			CALL	Comand
			BRA		CHECK


;-----------Subroutine for my Id------
MyID		MOVLW	D'68'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'69'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'57'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'54'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'53'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'56'
			MOVWF	PORTD, A
			CALL	WData
			
			MOVLW	D'56'
			MOVWF	PORTD, A
			CALL	WData

			
			MOVLW	0x01
			MOVWF	PORTD, A
			CALL	Comand
			
			BRA		CHECK1
;----------Subroutine fot LCD comand-----
Comand		BCF		LCDCONT,RS, A ;RS=0
			BCF		LCDCONT,RW, A ;RW=0
			BSF		LCDCONT,EN, A ;EN=1
			CALL	DELAY
			BCF		LCDCONT,EN, A ;EN=1
			RETURN

	
;--------Subroutine for write Data-----			
WData		BSF		LCDCONT,RS, A ;RS=0
			BCF		LCDCONT,RW, A ;RW=0
			BSF		LCDCONT,EN, A ;EN=1
			CALL	DELAY
			BCF		LCDCONT,EN, A ;EN=1
			RETURN


;--------Subroutine for keypad num------
SHOW0		MOVLW	D'48'
			MOVWF	PORTD, A
			CALL    WData
			RETURN	

SHOW1		MOVLW	D'49'
			MOVWF	PORTD, A
			CALL    WData
			RETURN	

SHOW2		MOVLW	D'50'
			MOVWF	PORTD, A
			CALL	WData
			RETURN

SHOW3		MOVLW	D'51'
			MOVWF	PORTD, A
			CALL	WData


SHOW4		MOVLW	D'52'
			MOVWF	PORTD, A
			CALL	WData

SHOW5		MOVLW	D'53'
			MOVWF	PORTD, A
			CALL	WData


SHOW6		MOVLW	D'54'
			MOVWF	PORTD, A
			CALL	WData

SHOW7		MOVLW	D'55'
			MOVWF	PORTD, A
			CALL	WData

SHOW8		MOVLW	D'56'
			MOVWF	PORTD, A
			CALL	WData

SHOW9		MOVLW	D'57'
			MOVWF	PORTD, A
			CALL	WData

SHOWSTAR	MOVLW	D'42'
			MOVWF	PORTD, A
			CALL	WData

SHOWHASTAG	MOVLW	D'35'
			MOVWF	PORTD, A
			CALL	WData
;----------Subroutine for line----------		
First		MOVLW	0x38
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x0F
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x01
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x80
			MOVWF	PORTD, A

			CALL	Comand	

Second		MOVLW	0xC0
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x0F
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x01
			MOVWF	PORTD, A

			CALL	Comand
			
			MOVLW	0x80
			MOVWF	PORTD, A

			CALL	Comand	



DELAY		MOVLW D'80'		;1sec delay subroutine for (external loop)
			MOVWF loop_cnt2,A
AGAIN1		MOVLW D'250'		;internal loop
			MOVWF loop_cnt1, A
AGAIN2		dup_nop	   D'247'
			DECFSZ	   loop_cnt1,F,A
			BRA	       AGAIN2
			DECFSZ	   loop_cnt2,F,A
			BRA		   AGAIN1
			NOP
			RETURN
			
			END
				
		