parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315s20_group05.yacc lex.yy.c
	yacc CS315s20_group05.yacc
lex.yy.c: CS315s20_group05.lex
	lex CS315s20_group05.lex
clean:
	rm -f lex.yy.c y.tab.c parser