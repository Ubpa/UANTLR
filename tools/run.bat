java org.antlr.v4.Tool CPP14Lexer.g4
java org.antlr.v4.Tool CPP14Parser.g4
javac *.java
grun CPP14 translationUnit -gui < test.h
