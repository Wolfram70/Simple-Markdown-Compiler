YFLAGS = -d

PROGRAM = markdown

OBJS = grammar.tab.o lex.yy.o

SRCS = grammar.tab.c lex.yy.c

CC = gcc 

all: $(PROGRAM)

.c.o:	$(SRCS)
		$(CC)	-c *.c

grammar.tab.c:	grammar.y
		bison $(YFLAGS) grammar.y

lex.yy.c:	lexical.l 
		flex lexical.l

markdown:	$(OBJS)
		$(CC)	-o $(PROGRAM) $(OBJS)

clean:
		rm $(OBJS) $(SRCS) grammar.tab.h