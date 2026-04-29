function isValid = validateCreditCard(cardNumber)
   % Code authors : Vidar Ersson & Maverick I. N.

   % Input space scenarios handled:
   % a. Valid and invalid card number lengths (13, 15, 16, 17, 19 digits — different credit card types have different valid lengths)
   % b. Valid and invalid card network prefixes (IIN/BIN ranges), e.g. Visa starts with 4, Mastercard with 51–55, Amex with 34 or 37
   % c. Correct and incorrect checksum digit (last digit)
   % g. 15-digit card numbers (American Express format), e.g. 378282246310005
   % h. 13-digit card numbers (old Visa format), e.g. 4222222222222
   % i. Too short input string
   % j. Too long input string
   % k. Characters, special characters, floats etc. as input strings
   % l. Incorrect or mixed separators (e.g. . or * instead of - or space)
   % n. Anything else you may find possible to fail the program

   % Test case l
   incorrectSeparators = ['*' '.' '_' ':' ';' ',' '|' '&'];

   if contains(cardNumber,'-') && contains(cardNumber,' ')
       disp("Mixed separators")
       return
   else 
       % Checks if the input contains an incorrect seperator
       for k=1:length(incorrectSeparators) 
           if contains(cardNumber, incorrectSeparators(k)) 
               disp("Incorrect separators")
               return
           end
       end
   end

   % Remove separators (spaces or dashes) and convert to array of digits
   cardNumber = strrep(cardNumber, '-', '');
   cardNumber = strrep(cardNumber, ' ', '');
   digits = double(cardNumber) - 48; % Convert ASCII to numeric values
   
   n = length(digits);
   
   % Test case i and j

   if n > 19 || n < 13
       if n > 19
           disp("Too long input string")
       else
           disp("Too short input string")
       end
       return
   end
    
   % Test case k
   for k=1:n
       % '.' and ',' have values -2 and -4 when converting ASCII to numeric
       if(digits(k) == -2 || digits(k) == -4)
           disp("Decimal number detected")
           return
       % Everything outside of "0-9" counts as a special character
       elseif(digits(k) > 9 || digits(k) < 0)
           disp("Special characters or letters detected")
           return
       end
   end

   % Test case a
   % Test case is redundant since we handle the entire card length range
   % Card lenghts 13-19
   acceptedCardLengths = [13 14 15 16 17 18 19];

   if ~ismember(n, acceptedCardLengths)
       disp("Invalid card length")
       return
   end

   % Test case b, n
   % Case n - Checks if the length of the card matches its IINs range of
   % card lengths
   
   % Visa, Mastercard, Amex, Diners Club International

   % Issuer identification number are the first digits that identify the
   % network that issued the card and are unique
   MastercardIIN = [51 52 53 54 55];
   AmexIIN = [34 37];
   DinersIIN = [30 36 38 39];
   Mastercard2017IIN = zeros(1,499); % Initializes array

   % Only two digit prefixes
   acceptedNetworkPrefixes = [MastercardIIN, AmexIIN, DinersIIN];

   % Fills array with all numbers in the range 2221:2720
   for k = 2221:2720
       i = -2220+k; % Start at first index
       Mastercard2017IIN(i) = k;
   end

   
   % Visa and "old Visa" share a single digit IIN
    
   if digits(1) == 4
       if n == 16 || n == 19
           creditCardType = 'Visa';
       elseif n == 13
           creditCardType = 'Old Visa';
       else
           disp('Invalid Visa credit card length')
           return
       end
   % Checks all of the two digit network prefixes
   elseif ismember(digits(1)*10+digits(2), acceptedNetworkPrefixes)
       if digits(1) == 5
           if n == 16
               creditCardType = 'Mastercard';
           else
               disp('Invalid Mastercard credit card length')
               return
           end
       elseif digits(2) == 4 || digits(2) == 7
           if n == 15
               creditCardType = 'Amex';
           else
               disp('Invalid Amex credit card length')
               return
           end
       else
           if ismember(n,acceptedCardLengths) && n ~= 13
               creditCardType = 'Diners';
           else
               disp('Invalid Diners credit card length')
               return
           end
       end
   % Turns eg. "4, 5, 3, 5" into "4535" and checks it against the accepted
   % Mastercard2017 IINs
   elseif ismember(digits(1)*1000+digits(2)*100+digits(3)*10+digits(4),Mastercard2017IIN)
       if n == 16
           creditCardType = 'Mastercard2017';
       else
           disp('Invalid Mastercard 2-Series credit card length')
           return
       end
   else
       disp('Invalid credit card prefix')
       return
   end
   disp(creditCardType)


   % Test case c

   % Calculate the Luhn checksum
   total = 0;
   % Changed i = 1 to i = 2 as to not use the check digit in the
   % calculation of the check digit
   for i = 2:n
      if mod(i, 2) == 0 
         doubledDigit = 2 * digits(n - i + 1);
         total = total + doubledDigit - (doubledDigit > 9) * 9;
      else
         total = total + digits(n - i + 1);
      end
   end

  % Check the check value
  if mod(10-(mod(total,10)),10) == digits(n)
      disp('Correct check value')
  else
      disp('Incorrect check value')
  end

   % A valid card number produces a total divisible by 10
   % Added "+digits(n)"
   isValid = (mod(total+digits(n), 10) == 0);
   if isValid
      disp('The credit card number is valid.');
   else
      disp('The credit card number is invalid.');
   end
end

