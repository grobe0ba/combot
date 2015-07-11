#!/usr/bin/sed -nf
#   Copyright (C) 2014 Lisa Marie Maginnis

#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
