rm toprint.txt

## set it to 1:  If you want to compile and run all .java files one by one. It will still print all the files to "toPrint.txt"
## set it to 0: Select if you do not want any .java file to compile or run. It will only print all the files to "toPrint.txt"

##lab # 16 is project # 4
##lab # 20 is project # 5
##lab # 24 is project # 6
##lab # 28 is project # 7


## lab # 45 is closed lab # 11
##lab #49 is closed lab # 12


toCompileAndRun=1


labNo=44

javac Random.java

if [ $labNo -eq 7 ]
then
if [ $toCompileAndRun -eq 1 ]
then
	echo $CLASSPATH
	echo $PWD
	export CLASSPATH=$CLASSPATH:$PWD/Lab7.jar ##only for Lab 7
fi
fi

echo $CLASSPATH

##rename zip files
find . -name '* *' | while read file;
do
target=`echo "$file" | sed 's/ /_/g'`;
echo "Renaming '$file' to '$target'";
mv -f "$file" "$target";
done;

##unzip the zip files
 for i in `ls -1 *.zip`;do 
	j=`echo $i| sed 's/.zip//g'`
	unzip -o -q -d $j $i
	
done;

##unrar the rar files
 for i in `ls -1 *.rar`;do 
	j=`echo $i| sed 's/.rar//g'`
	echo "Now extracting $i to $j"	
	mkdir $j
	unrar x -o+ $i $j
	
done;

##rename the files inside the folder
find . -name '* *' | while read file;
do
target=`echo "$file" | sed 's/ /_/g'`;
echo "Renaming '$file' to '$target'";
mv -f "$file" "$target";
done;


echo "Now starting to compile, print etc."

##look for java files inside folders and move them up to the top level
for i in `ls -1 -d */`; do
cd $i
echo $i
###echo '\f' >> ../toprint.txt

##find . -name "*.java" | while read file;
for file in `find . -name "*.java"`
do
if [ `ls -l $file | awk '{print $5}'` -eq 0 ]
then
echo "ERROR: $file is empty"
fi
##move to level up for moss
if [ `echo $file | sed 's/[^/]//g' | tr -d " " | wc -m` -ne 2 ]
then
mv -f $file .  || echo "Error moving file $PWD $file"
fi
done; ##end of while
cd ..
done; ## end of for


##look for java files inside folders at top level 
##compile them
## and print them
for i in `ls -1 -d */`; do
cd $i
echo '\f' >> ../toprint.txt
echo '\f' >> ../toprint.txt #necessary if printing 2 side, remove for printing 1 side
for file in `find . -name "*.java"`
do
echo "************************************************">>../toprint.txt
echo "************************************************">>../toprint.txt
echo "************************************************">>../toprint.txt
if [ `ls -l $file | awk '{print $5}'` -eq 0 ]
then
echo "ERROR: $file is empty"
fi
if [ $toCompileAndRun -eq 1 ]
then

echo "************************************************"
echo "************************************************"

##if [ $labNo -eq 4 || $labNo -eq 16]
##then
	cp ../Random.class .
	cp ../in.txt .
	cp ../words.txt .
	cat $file | sed 's/import java\.util\.Random;//g' |  sed 's/Math\.Random/myrand/g' | sed 's/Math\.random/Random.myrand/g' > temp222.java
	##cat $file  > temp222.java
	cp temp222.java $file
	rm temp222.java
##fi

cat $file | sed 's/^[ \t]*package.*//g' > $file.2
mv $file.2 $file
javac -extdirs .. $file;
enter=1
ls



	
echo "Compiled $PWD $file...Now executing..enter which file to take as input to continue";
	while read enter; do
	     if [[ -z "${enter}" ]]; then
		  echo "That was empty, do it again!"
	     else
		  echo "Checking now..."
		  break
	     fi
	done

echo $file
classfile=`echo $file | sed 's/.java/.class/g'`;
classfile2=`echo $classfile | sed 's/\.class//g' | sed 's/.*\///g'`;
for copy in 1 2 3 4 5 6 7 8 9 10
do
	inputFile=inputDataLabPart$enter\_$copy\.txt
	if [ -f ../$inputFile ]
	then
		echo
		if [ $labNo -eq 53 ] || [ $labNo -eq 44 ]
		then
			rm out.txt
		fi
		java  $classfile2 < ../$inputFile
		if [ $labNo -eq 53 ] || [ $labNo -eq 44 ]
		then
			echo "Outputting out.txt start"
			cat out.txt
			echo "Outputting out.txt end"
		fi
	fi
	if [ $labNo -eq 6 ]
	then
		j=0
		for k in `java  $classfile2 < ../$inputFile | grep -i -o "([0-9]*)" | tr -d "(" | tr -d ")" `; do  j=`expr $j + $k`; done; echo Total numbers=$j 
	fi

	
	
done

if [ -f $classfile ]
then
echo
#rm $classfile
fi
if [ -f $classfile2.class ]
then
echo
#rm $classfile2.class
fi
echo "Ran the classfile $PWD $classfile...enter to continue";
read enter;
echo "Now displaying source code"
sleep 1;
gedit $file
echo $enter;
fi
echo $PWD >> ../toprint.txt
echo $file >>../toprint.txt
echo>>../toprint.txt
echo>>../toprint.txt
cat $file >> ../toprint.txt
done; ##end of while
cd ..
done; ## end of for

exit;

##look for java files at top level
for i in `ls -1 *.java`; do
echo "Strange java file found at $PWD $i"
echo "Check Manually"
echo '\f' >> toprint.txt
#echo '\f' >> toprint.txt #necessary if printing 2 side, remove for printing 1 side
echo "************************************************">>toprint.txt
echo "************************************************">>toprint.txt
echo "************************************************">>toprint.txt
if [ `ls -l $i | awk '{print $5}'` -eq 0 ]
then
echo "ERROR: $i is empty"
fi
pwd >> toprint.txt
echo $i >>toprint.txt
echo>>toprint.txt
echo>>toprint.txt
cat $i >> toprint.txt
done;
