#!/bin/bash

if [ $# == 0 ]; then
    echo "nie podano żadnych argumentów"
    exit 1
fi

name="$1"
name_len=${#name}
last_char="${name:$name_len-1}"

# Możemy założyć, że imie jest żeńskie jeśli ostatnia litera imienia to 'a'
if [ $last_char == 'a' ]; then
    # Tutaj sama podmiana 'a' na 'ę' nie wystarczy, bo imię może mieć 'a' nie tylko na końcu
    # Dodatkowo, zapis substytucji (${var/from/to}) zamienia tylko pierwszy napotkany przypadek
    # Np. 'Małgorzata'/a/e -> 'Męłgorzata'
    # Zamiast substytucji wypiszę imię do przedostatniej litery i dodam na koniec 'ę'
    echo "${name} ma kota, a kot ma ${name:0:$name_len-1}ę"
else
    last_two_chars=${name:$name_len-2}

    # Dla męskich imion zakładamy specjalny przypadek, gdzie imię kończy się na 'ek'
    # Wtedy zamieniamy 'ek' -> 'ka'
    # Dla reszty męskich imion dodajemy na końcu 'a'
    if [ $last_two_chars == 'ek' ]; then
        # Np. Marek -> Marka, Jarek -> Jarka
        echo "${name} ma kota, a kot ma ${name:0:$name_len-2}ka"
    else
        # Np. Janusz -> Janusza, Przemysław -> Przemysława
        echo "${name} ma kota, a kot ma ${name}a"
    fi
fi
