while true
do
  operand="XXX"
  while [[ "$operand" =~ ^("C"|"XXX")$ ]]
  do
    read -p "Enter Operand: " operand
    if [ "$operand" = 'MR' ] && [[ -z $memory ]] 
    then
      operand="XXX"
      echo "There is still no memory stored"
      continue
    elif [ "$operand" = 'MR' ] && [[ -n $memory ]] && [[ -z $result ]] 
    then
      result=$memory
      echo "result is: $result"
    elif [ "$operand" = 'MR' ] && [[ -n $memory ]] && [[ -n $result ]] 
    then
      ((result=$(($memory$operator$result)))) 
      echo "result is: $result"
    elif [ "$operand" = 'MC' ] && [[ -z $result ]]
    then 
      memory=0
      operand="XXX"
    elif [ "$operand" = 'MC' ] && [[ -n $result ]]
    then
      memory=0
    elif [ "$operand" = 'C' ] && [[ -z $result ]]
    then
      echo "Result is not existant yet"
    elif [ "$operand" = 'C' ] && [[ -n $result ]]
    then
      unset result
      echo "result has been cleared"  
    elif [ "$operand" = 'X' ]
    then
      echo ""
      echo "The program is done ^__^!"
      echo "Final Summary of Variables"
      if [ -z $result ]
      then
        echo "Result Non Existant"
      elif [ -n $result ]
      then
        echo "Final Result Value is: $result"
      fi
      if [ -z $memory ]
      then
        echo "memory Non Existant"
      elif [ -n $memory ]
      then
        echo "Final Memory Value is: $memory"
      fi

      exit
    elif [[ -z $result ]]
    then
      result=$operand
      echo "result is: $result"
    elif [[ -n $result ]] && [[ "$operator" = '/' ]] && [[ "$operand" = '0' ]]
    then 
      echo "Can't divide by zero, enter valid divisor"
      operand="XXX"   
    elif  [[ -n $result ]]
    then
      ((result=$(($result$operator$operand))))
      echo "result is: $result"
    fi 

  done
  operator="XXX"
  while [[ "$operator" =~ ^("MS"|"M+"|"MC"|"XXX")$ ]]
  do
    read -p "  Enter Operator: " operator
    if ! [[ "$operator" =~ ^("MS"|"M+"|"MC"|"C"|"/"|"*"|"+"|"-"|"X")$ ]]
    then
      echo "Operator $operator is not valid please enter one of the following operators (MS,M+,MC,C,X,/,*,+,-)"
    operator="XXX"
    continue
    fi

    if [ "$operator" = 'MS' ] && [[ -z $result ]]
    then
      echo "There is still no result stored"
    elif [ "$operator" = 'MS' ] && [[ -n $result ]]
    then
      memory=$result  
      echo "memory is: $memory"
    elif [ "$operator" = 'M+' ] && [[ -z $result ]]
    then
      echo "There's no result yet"
    elif [ "$operator" = 'M+' ] && [[ -z $memory ]] && [[ -n $result ]]
    then
      echo "There's a result but there's not memory yet"
    elif [ "$operator" = 'M+' ] && [[ -n $memory ]] && [[ -n $result ]]
    then
      ((memory=$memory+$result))
      echo "memory is: $memory"

    elif [ "$operator" = 'C' ]
    then
      unset result
      echo "result has been cleared"
    elif [ "$operator" = 'X' ]
    then
      echo ""
      echo "The program is done ^__^!"
      echo "Final Summary of Variables"
      if [ -z $result ]
      then
        echo "Result Non Existant"
      elif [ -n $result ] 
      then
        echo "Final Result Value is: $result"
      fi
      if [ -z $memory ]
      then
        echo "memory Non Existant"
      elif [ -n $memory ]
      then
        echo "Final Memory Value is: $memory"
      fi

      exit
    fi  
  done

  
done

