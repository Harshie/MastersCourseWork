CC=gcc
CFLAGS=-I.
DEPS = numericalintegration.h
OBJ = mainfunc.o trepezoidal.o gaussquadrature.o simpson.o

%.o:%.c $(DEPS)
	$(CC) -c -lm -o $@ $< $(CFLAGS)
area:$(OBJ) 
	$(CC) -lm -o $@ $^ $(CFLAGS)

clean:
	rm $(OBJ)
