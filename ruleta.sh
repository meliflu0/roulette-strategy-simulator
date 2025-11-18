#!/bin/bash

greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"
redC="\e[0;31m\033[1m"
blueC="\e[0;34m\033[1m"
yellowC="\e[0;33m\033[1m"
purpleC="\e[0;35m\033[1m"
turquoiseC="\e[0;36m\033[1m"
grayC="\e[0;37m\033[1m"

function ctrl_c(){

  echo -e "\n[+] Saliendo...\n"
  tput cnorm;  exit 1
}

# control+c
trap ctrl_c INT

function helpPanel(){

  echo -e "\n${yellowC}[+] ${endC}${grayC}Uso: ${endC}${purpleC}$0${endC}\n"
  echo -e "\t${blueC}-m)${endC}${grayC} Dinero con el que desea jugar${endC}\n"
  echo -e "\t${blueC}-t)${endC}${grayC} Tecnica a utilizar ${purpleC}(${endC}${yellowC}martingala${endC}${purpleC}/${endC}${yellowC}inverseLabrouchere${endC}${purpleC})${endC}\n"
  exit 1
}

function martingala(){

  echo -e "\n${yellowC}[+]${endC}${grayC} Balance actual:${endC}${greenC} \"$\"$money${endC}\n" | tr -d '"'
  echo -ne "${blueC}[*]${blueC}${grayC} ¿Cuanto dinero quieres apostar? ->${grayC} " && read initial_bet
  echo -ne "${blueC}[*]${endC}${grayC} ¿A que deseas apostar continuamente (par/impar)? ->${endC} " && read par_impar
  echo -e "\n${yellowC}[+]${endC}${grayC} Vamos a jugar con una cantidad inicial de ${endC}${yellowC}\"$\"$initial_bet${endC} ${grayC}a${endC} ${yellowC}$par_impar${endC}" | tr -d '"'
  backup_bet=$initial_bet
  play_counter=1
  malas_jugadas=""
  maximo_monto="$money"
  tput civis #Ocultar el cursor
  while true; do 

    money=$(($money-$initial_bet))
#   echo -e "\n${yellowC}[+]${endC}${grayC} Acabas de apostar${endC}${redC} \"$\"$initial_bet${endC}${grayC} y tu balance actual es de${endC}${greenC} \"$\"$money${endC}" | tr -d '"'
    random_number="$(($RANDOM % 37))"
#   echo -e "${yellowC}[+]${endC} ${grayC}Ha salido el número${endC}${blueC} $random_number${endC}"

    if [ ! "$money" -lt 0 ]; then
      if [ "$par_impar" == "par" ]; then 
        if [ "$(($random_number % 2))" -eq 0 ]; then
          if [ "$random_number" -eq 0 ]; then

#             echo -e "${yellowC}[+]${endC} ${grayC}Ha salido${endC}${greenC} 0${endC}${grayC},${endC}${redC} ¡Perdiste \"$\"$initial_bet!${endC}" | tr -d '"'
#             echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
              initial_bet=$(($initial_bet*2))
              malas_jugadas+="$random_number "

          else
            if [ "$money" -gt "$maximo_monto" ]; then 
            reward=$(($initial_bet * 2))
            money=$(($money+$reward))

#           echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es par,${endC} ${greenC}¡Ganaste \"$\"$reward!${endC}" | tr -d '"'
#           echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
            initial_bet=$backup_bet
            malas_jugadas=""
            maximo_monto="$money"
#           echo -e "${yellowC}[+]${endC}${grayC} Maxima ganancia obtenida fue de ${endC}${yellowC}\"$\"$maximo_monto${endC}" | tr -d '"'

          else
            reward=$(($initial_bet * 2))
            money=$(($money+$reward))

#           echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es par,${endC} ${greenC}¡Ganaste \"$\"$reward!${endC}" | tr -d '"'
#           echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
            initial_bet=$backup_bet
            malas_jugadas=""
            fi
          fi
        else
#          echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es impar,${endC}${redC} ¡Perdiste \"$\"$initial_bet!$endC" | tr -d '"'
#         echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
          initial_bet=$(($initial_bet*2))
          malas_jugadas+="$random_number "
        fi
        else 
          if [ "$(($random_number % 2))" -eq 1 ]; then

                  if [ ! "$money" -gt "$maximo_monto" ]; then 
                  reward=$(($initial_bet * 2))
                  money=$(($money+$reward))

#                  echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es impar,${endC} ${greenC}¡Ganaste \"$\"$reward!${endC}" | tr -d '"'
#                  echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
                  initial_bet=$backup_bet
                  malas_jugadas=""
                else 
                  reward=$(($initial_bet * 2))
                  money=$(($money+$reward))

#                  echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es impar,${endC} ${greenC}¡Ganaste \"$\"$reward!${endC}" | tr -d '"'
#                  echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
                  initial_bet=$backup_bet
                  malas_jugadas=""
                  maximo_monto="$money"
        #            echo -e "${yellowC}[+]${endC}${grayC} Maxima ganancia obtenida fue de ${endC}${yellowC}\"$\"$maximo_monto${endC}" | tr -d '"'
                  fi
              else
#                 echo -e "${yellowC}[+]${endC}${grayC} El número que ha salido es par,${endC}${redC} ¡Perdiste \"$\"$initial_bet!$endC" | tr -d '"'
#                 echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es${endC} ${greenC}\"$\"$money" ${endC}| tr -d '"'
                initial_bet=$(($initial_bet*2))
                malas_jugadas+="$random_number "
              fi

      fi
  else
    echo -e "\n${redC}[!] Te quedaste sin pasta cabrón${endC}"
    echo -e "\n${yellowC}[+]${endC}${grayC} El número total de jugadas fueron${endC}${yellowC} $(($play_counter-1))${endC}"
    echo -e "\n${yellowC}[+]${endC}${grayC} Tu ganacia maxima fue de:${endC}${yellowC} \"$\"$maximo_monto${endC}" | tr -d '"'
    echo -e "\n${yellowC}[+]${endC}${grayC} A continuación se van a respresentar las malas jugadas consecutivas que han salido:${endC}\n\n${blueC}[ $malas_jugadas]${endC}"
      tput cnorm; exit 0
    fi

    let play_counter+=1

  done
tput cnorm #Mostrar cursor
}

function inverseLabrouchere(){

  echo -e "\n${yellowC}[+]${endC}${grayC} Balance actual:${endC}${greenC} \"$\"$money${endC}\n" | tr -d '"'
  echo -ne "${blueC}[*]${endC}${grayC} ¿A que deseas apostar continuamente (par/impar)? ->${endC} " && read par_impar

  declare -a my_sequence=(1 2 3 4)

  echo -e "\n${yellowC}[+]${endC}${grayC} Comenzamos con la secuencia:${endC} ${greenC}[${my_sequence[@]}]${endC}"

  bet=$((${my_sequence[0]}+${my_sequence[-1]}))

  echo -e "${yellowC}[+]${endC}${grayC} Invertimos ${endC}${yellowC}\"$\"$bet ${endC}" | tr -d '"'
  jugadas_totales=0

  tput civis
  while true; do 
    let jugadas_totales+=1
    random_number=$(($RANDOM % 37))
    money=$(($money-$bet))

    if [ ! "$money" -lt 0 ]; then
      echo -e "\n${yellowC}[+]${endC}${grayC} Acabas de apostar${endC}${redC} \"$\"$bet${endC}${grayC} y tu balance actual es de${endC}${greenC} \"$\"$money${endC}" | tr -d '"'

      echo -e "\n${yellowC}[+]${endC}${grayC} Ha salido el número ${endC}${blueC}$random_number${endC}"
    
    if [ "$par_impar" == "par" ]; then
      if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then

        echo -e "${yellowC}[+]${endC}${grayC} El número es par${endC}${greenC} ¡Ganaste!${endC}"
        reward=$(($bet * 2))
        let money+=$reward
        echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es de${endC}${greenC} \"$\"$money${endC}" | tr -d '"'

        my_sequence+=($bet)
        my_sequence=(${my_sequence[@]})
         
        echo -e "${yellowC}[+] ${endC}${grayC}Nuestra nueva es de${endC}${greenC} [${my_sequence[@]}]${endC}"

        if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then 
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
        elif [ ${#my_sequence[@]} -eq 1 ]; then 
          bet=${my_sequence[0]}
        else 
          echo -e "${redC}[!] Hemos perdido nuestra secuencia${endC}"
          my_sequence=(1 2 3 4)
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          echo -e "${yellowC}[+]${endC}${grayC} Restablecemos la secuencia a:${endC}${greenC} [${my_sequence[@]}]${greenC}"
        fi

      elif [ $(($random_number % 2)) -eq 1 ] || [ "$random_number" -eq 0 ]; then
        if [ $(($random_number % 2)) -eq 1 ]; then 

        echo -e "${redC}[!]${endC}${grayC} El número es impar${endC}${redC} ¡Pierdes!${endC}"
        else
        echo -e "${redC}[!]${endC}${grayC} El número que ha salido es${endC}${blueC} 0${endC}${redC} ¡Pierdes!${endC}"
        fi

        unset my_sequence[0]
        unset my_sequence[-1] 2>/dev/null

        my_sequence=(${my_sequence[@]})
        
        echo -e "${yellowC}[+]${endC}${grayC} Tu balance actual es de${endC}${greenC} \"$\"$money${endC}" | tr -d '"'

        echo -e "${yellowC}[+]${endC}${grayC} La secuencia se nos queda de la siguiente forma:${endC}${greenC} [${my_sequence[@]}]${endC}"

        if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then 
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
        elif [ ${#my_sequence[@]} -eq 1 ]; then 
          bet=${my_sequence[0]}
        else 
          echo -e "${redC}[!] Hemos perdido nuestra secuencia${endC}"
          my_sequence=(1 2 3 4)
          bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          echo -e "${yellowC}[+]${endC}${grayC} Restablecemos la secuencia a:${endC}${greenC} [${my_sequence[@]}]${greenC}"
        fi

      fi
    fi
  else
    echo -e "\n${redC}[!] Te quedaste sin pasta cabrón${endC}"
    echo -e "\n${yellowC}[+]${endC}${grayC} El número total de jugadas fueron${endC}${yellowC} $jugadas_totales${endC}"
    tput cnorm; exit 0
  fi

  done
  tput cnorm

}

while getopts "m:t:h" arg; do

  case $arg in
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;

  esac

done

if [ $money ] && [ $technique ]; then 
if [ "$technique" == "martingala" ]; then 
  martingala
elif [ "$technique" == "inverseLabrouchere" ];then 
  inverseLabrouchere
else
  echo -e "\n${redC}[!] La tecnica introducida no existe${endC}"
  helpPanel
fi
else

  helpPanel

fi
