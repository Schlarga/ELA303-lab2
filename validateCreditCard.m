function isValid = validateCreditCard(cardNumber)
   % Remove separators (spaces or dashes) and convert to array of digits
   cardNumber = strrep(cardNumber, '-', '');
   cardNumber = strrep(cardNumber, ' ', '');
   digits = double(cardNumber) - 48; % Convert ASCII to numeric values
   
   n = length(digits);
   
   % Test case a
   % Card lenghts 13-19
   acceptedCardLengths = [13 14 15 16 17 18 19];

   if ismember(n, acceptedCardLengths)
       
   else
       if n < 13
           disp('Too short input')
       else
           disp('Too long input')
       end
       return
   end

   % Test case b
   % Visa, Mastercard, Amex, Diners Club International

   VisaIIN = [4];
   
   MastercardIIN = [51 52 53 54 55];

   for k = 2221:2720
       i = -2220+k; % Start at first index
       Mastercard2017IIN(i) = k;
   end

   AmexIIN = [34 37];

   DinersIIN = [30 36 38 39];

   acceptedNetworkPrefixes = [MastercardIIN, AmexIIN, DinersIIN];
   
   creditCardType = ' ';
    
   if digits(1) == 4
       creditCardType = 'Visa';
   elseif ismember(digits(1)*10+digits(2), acceptedNetworkPrefixes)
       if digits(1) == 5
           creditCardType = 'Mastercard';
       elseif digits(2) == 4 || digits(2) == 7
           creditCardType = 'Amex';
       else
           creditCardType = 'Diners';
       end
   elseif ismember(digits(1)*1000+digits(2)*100+digits(3)*10+digits(4),Mastercard2017IIN)
       creditCardType = 'Mastercard2017';
   else
       disp('Invalid credit card prefix')
       return
   end
   disp(creditCardType)

   % Test case c

   % Calculate the Luhn checksum
   total = 0;
   % Changed i = 1 to i = 2
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



