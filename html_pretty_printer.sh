#!/bin/bash

# eroare nr argumente
if [ "$#" -ne 1 ]; then
    echo "Input invalid! Numar de argumente gresit!"
    exit 1
fi

input=$1

# eroare fisierul nu exista
if [ ! -f "$input" ]; then
    echo "Eroare: Fisierul '$input' nu exista in memorie"
    exit 1
fi

# numele fisierului output
output="${input%.*}_formatted.html"

intermediar=$(mktemp)

# adaugam in fisierul intermediar fiecare tag pe cate o linie noua
awk '
{
    # newline inainte de opening tag
    gsub(/</, "\n<",$0)
    # newline dupa closing tag
    gsub(/>/, ">\n",$0)
    print
}
' "$input" | sed '/^[[:space:]]*$/d' > "$intermediar"

nr_tab=0

# lista tagurilor care nu se inchid (html5 void)
void_tags="area|base|br|col|embed|hr|img|input|link|meta|param|source|track|wbr"

# adaugam tab
indent() {
    local nr=$1
    for((i=0;i<nr;i++));do
        printf "    "
    done
}

{
    while IFS= read -r linie; do
        #eliminam spatiile de la inceputul si sfarsitul liniei
        linie=$(echo "$linie" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        # tag de inchidere
         if echo "$linie" | grep -qE '^</'; then
            ((nr_tab--))
        fi

        # inseram nr de tab si afisam linia
        indent $nr_tab
        echo "$linie"

        # tag de deschidere (fara comentarii si auto-inchise)
        if echo "$linie" | grep -qE '^<[^/!][^>]*>$'; then
            ((nr_tab++))
        fi
        
        # verificam daca este auto-inchis (terminat in />) SAU este un tag html5 void
         if echo "$linie" | grep -qE '^<[^/!][^>]*/>$' || echo "$linie" | grep -qE -i "^<($void_tags)([[:space:]]|>)"; then
            ((nr_tab--))
        fi
        
    done
}  < "$intermediar" > "$output"

rm "$intermediar"

# validare fisier input
if [ "$nr_tab" -eq 0 ]; then
    echo "HTML-ul formatat a fost salvat in '$output'."
else
    echo "Eroare: Nu este cod html valid sintactic (tag-uri neinchise sau inchise gresit)!"
    rm "$output"
fi