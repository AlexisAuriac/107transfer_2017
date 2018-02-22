##
## EPITECH PROJECT, 2017
## 107transfer
## File description:
## Makefile for 107transfer
##

NAME	=	107transfer

all	:	$(NAME)

$(NAME)	:
		cp transfer.pl $(NAME)

fclean	:
		rm -f $(NAME)

re	:	fclean	all

.PHONY	:	all  fclean  re
