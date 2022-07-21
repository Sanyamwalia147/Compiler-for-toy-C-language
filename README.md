# Compiler-for-toy-C-language
Compiler for toy C language using Flex(lex) and Bison(yacc)


README file
 Created by Sanyam Walia
	    2020CSB1122
	    
 FILES: This directory contains the following files-
        cucu.l
        cucu.y
        Sample1.cu - File containing Lexically and Suntactically correct code
        Sample2.cu - File containing invalid code (Lexically or Suntactically)
        README.txt	    
	
--------------------------------------------------------------------------------------------------------
 
 To run the programme, open the terminal on your system.
 Navigate to the directory containing the files and execute the following commands
 	
	flex cucu.l
	bison -d cucu.y  (ignore warnings and run the next command)
	g++ cucu.tab.c lex.yy.c -lfl -o cucu
	./cucu (Filename of the input file) - Eg ./cucu Sample1.cu  or ./cucu Sample2.cu
	
	after all these, you will get two output files generated namely, Lexer.txt and Parser.txt
	   	   
========================================================================================================

 ASSUMPTION MADE RELATED TO PROBLEMS:

 1. Negative numbers not allowed: as they were confusing eg. int i=-2; or i=3-2; was confusing for Parser
 2. Every variable must be declared in a new line. int a, b; is not allowed.
 3. Only char* and int are allowed in declaration, in usage, id[expr] is also allowed.
 
 ******************** IMPORTANT
 4. When I was compiling the code on my Linux OS, there was some problem and the compiler was unable to 
    recognize the EOF. So, every file (Sample1.cu, Sample2.cu etc) must have a '.' (DOT) at the end to
    denote EOF.
 ********************
 
 For more rules, see the cucu.y file to understand the grammar.
 
 Rest, the outputs are obtained as per requirement and the Lexer and Parser also indicate the line no. 
 in case of errors if any.

                                                                                    
========================================================================================================
End of README.txt
