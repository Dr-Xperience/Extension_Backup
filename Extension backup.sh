#!/bin/bash
#/****************************************************************************
#    Media Take : A Qt and GStreamer Based cross platform Media Player for PC
#    Copyright (C) 2012  Anubhav Arun <dr.xperience@gmail.com>
#    
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

*****************************************************************************/
########################################################################################################################
#  TITLE    : PROGRAM TO COPY ALL THE CONTENTS OF HOME DIRECTORY IN INTO A USB STICK AND CLASSIFY THEM ACCORDING TO THEIR EXTENTION
#  BY       : ANUBHAV ARUN GUPTA ; REGISTRATION NUMBER 11000527 ; ROLL NUMBER : RK1R04A04
#  VERSION  : 3.0
#  MFD      : TUESDAY,03 APRIL, 2012 , 23:47:30 HRS
#########################################################################################################################

path="/media/Anubhav Arun Gupta"
cd ~

# FUNCTION TO CREATE THE LIST OF FILES HAVING EXTENTIONS IN THE USB STICK
list()
{

for i in * .*
do

if ( ( [ -d "$i" ] ) && ( [ "$i" != ".." ] ) && ( [ "$i" != "." ] ) ) then

cd "$PWD/$i"

list

else

if ( ( [ "$i" != ".." ] ) && ( [ "$i" != "." ] ) ) then

j=`echo "$i" | grep '\..*$' | awk -F . '{print$NF}'`

if ( [[ $i =~ \..*$ ]] ) then
echo ".$j" >> "$path/islist"
fi

fi

fi
done
cd ..
}

list

cd "$path"

# STORING THE CONTENTS OF THE FILE IN A VARIABLE
j=`cat islist`
rm islist #list
if ( ! [ -e ".backup" ] ) then
mkdir .backup
fi
cd .backup

#LOOP TO MAKE FOLDER ACCORDING TO THE EXTENTIONS OF THE FILE IN THE HOME DIRECTORY
for i in $j
do

if ( ! [ -e "$i" ] ) then
mkdir "$i" 
fi

done

if ( ! [ -e ".Unknown" ] ) then
mkdir ".Unknown" 
fi

folder=`ls -a1`

cd 

#FUNCTION TO COPY THE CONTENTS OF HOME DIRECTORY IN TO THE APPROPRIATE FOLDER IN THE USB STICK
back()
{

for i in * .*
do

if ( ( [ -d "$i" ] ) && ( [ "$i" != ".." ] ) && ( [ "$i" != "." ] ) ) then
cd "$PWD/$i"
back

else
if ( ( [ "$i" != ".." ] ) && ( [ "$i" != "." ] ) ) then
j=`echo "$i" | awk -F . '{print$NF}'`

exist=0 

for k in $folder
do

if ( [ "$k" = ".$j" ] ) then
cp "$i" "$path/.backup/$k"
exist=0
break
else
exist=1
fi

done

if ( [ $exist -eq 1 ] ) then
cp "$i" "$path/.backup/.Unknown"
fi

fi
fi

done
cd ..
}

back
