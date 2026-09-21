#!/bin/bash

read -p "Eter a number of your subjects : " subjects
total=0
for (( i=1; i<= subjects; i++)); do
       read -p "Enter a $i mark : " mark
       total=$((total + mark))
done

m_mark=$((subjects * 100))

per=$(( (total*100) / m_mark ))

echo "Mark obtained : $total"
echo "Percentage obtained : $per"

if [[ per -ge 80 ]]; then
	echo "Your grade is A"

elif [[ per -ge 60 ]]; then
	echo "Your grade is B"

elif [[ per -ge 40 ]]; then
	echo "Your grade is C"

elif [[ per -ge 33 ]]; then
	echo "Your grade is D"

else
	echo "You are fail"
fi

