prefix=/usr/local
bindir=$(prefix)/bin
datarootdir=$(prefix)/share
#local defines
NVCC=nvcc
NVCC_OPTS=-arch=sm_53 -Xcompiler -Wall -Xcompiler -Wextra -m64
GCC_OPTS=-03 -Wall -Wextra

#	default cuda lib path:
CUDA_INCLUDEPATH=/usr/local/cuda/include

#	linker
prog:	pacman.o agent.o  Makefile
	$(NVCC) -o prog pacman.o agent.o -lncurses
	#g++ -o prog main.o sudoku.o color.o
	

install:
	mkdir -p $(DESTDIR)$(bindir)
	#cp pacman $(DESTDIR)$(bindir)
	#cp pacmanedit $(DESTDIR)$(bindir)
	mkdir -p $(DESTDIR)$(datarootdir)/pacman
	cp -fR Levels/ $(DESTDIR)$(datarootdir)/pacman/
	#-chown root:games $(DESTDIR)$(bindir)/pacman
	#-chown root:games $(DESTDIR)$(datarootdir)/pacman -R
	#chmod 750 $(DESTDIR)$(bindir)/pacman
	#chmod 750 $(DESTDIR)$(datarootdir)/pacman/ -R



#	main-program
#timer.h utils.h sudoku.cpp
pacman.o:	pacman.h	agent.h 
	gcc -c pacman.c -I $(CUDA_INCLUDEPATH) 
	#$(GCC_OPTS) -I $(CUDA_INCLUDEPATH)

agent.o:	agent.cu	agent.h
	nvcc -c agent.cu $(NVCC_OPTS)
	#nvcc -std=c++11 -c -arch=sm_20 student_func.cu


#	own commands:
#	define 'make clean' command:
clean : 
	rm -f 
	rm *.o
	rm prog

#	define 'make run' command:
run: prog
	./prog input.txt $(var)
