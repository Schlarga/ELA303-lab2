ELA303 - Robust Electronics for Dependable Systems

LAB2 - Credit Card Number Validation Using the Luhn Algorithm
Robustness Testing

Test Cases Handled:

a.	Valid and invalid card number lengths (13, 15, 16, 17, 19 digits — different credit card types have
different valid lengths)

b.	Valid and invalid card network prefixes (IIN/BIN ranges), e.g. Visa starts with 4, Mastercard with
51–55, Amex with 34 or 37

c.	Correct and incorrect checksum digit (last digit)

g.	15-digit card numbers (American Express format), e.g. 378282246310005

h.	13-digit card numbers (old Visa format), e.g. 4222222222222

i.	Too short input string

j.	Too long input string

k.	Characters, special characters, floats etc. as input strings

l.	Incorrect or mixed separators (e.g. . or * instead of - or space)

