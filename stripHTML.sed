#!/usr/bin/sed -nf
#< All credit for this script goes to nullogic@sdf.org

#< strip HTML tags from input

: loop
/<.*>/ {
         #if we have a HTML tag, remove it
         s/<[^<>]*>//g

         #branch if a successful substitution was made
         t loop
}
/</ {
         #if just an opening tag is found, append the
         #next line of input into the pattern space
         N
         b loop
}

# print the rest!
p
