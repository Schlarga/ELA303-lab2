ELA303 - Robust Electronics for Dependable Systems

LAB2 - Credit Card Number Validation Using the Luhn Algorithm
Robustness Testing

Test Cases:

a.	Valid and invalid card number lengths (13, 15, 16, 17, 19 digits — different credit card types have
different valid lengths)

b.	Valid and invalid card network prefixes (IIN/BIN ranges), e.g. Visa starts with 4, Mastercard with
51–55, Amex with 34 or 37

c.	Correct and incorrect checksum digit (last digit)

d.	Incorrectly typed digit (only one digit changed) — note: this test is valid to detect double entry of a
digit as well

e.	Swapped adjacent digits

f.	Card numbers with and without separators (spaces or dashes), e.g. 4111-1111-1111-1111 and
4111 1111 1111 1111

g.	15-digit card numbers (American Express format), e.g. 378282246310005

h.	13-digit card numbers (old Visa format), e.g. 4222222222222

i.	Too short input string

j.	Too long input string

k.	Characters, special characters, floats etc. as input strings

l.	Incorrect or mixed separators (e.g. . or * instead of - or space)

m.	All identical digits (e.g. 1111111111111111, 0000000000000000)

n.	Anything else you may find possible to fail the program