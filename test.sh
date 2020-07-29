#!/bin/bash


ID_REGEX='[0-9]{9}'
if [[ ! "$(head -5 ex11.sh)" =~ $ID_REGEX ]]; then
	echo You forgot id in ex11.sh!!!
fi
if [[ ! "$(head -5 ex12.sh)" =~ $ID_REGEX ]]; then
	echo You forgot id in ex12.sh!!!
fi
if [[ ! "$(head -5 ex13.sh)" =~ $ID_REGEX ]]; then
	echo You forgot id in ex13.sh!!!
fi
if [[ ! "$(head -5 ex14.sh)" =~ $ID_REGEX ]]; then
	echo You forgot id in ex14.sh!!!
fi

# Test file for ex1

touch testerrors
touch testresult
cat > testerrors << EOF
Usually mkdir errors are OK in the second+ run of the test.
EOF
cat > testresult << EOF
EOF

testresult=$(echo $(pwd)/testresult)
testerrors=$(echo $(pwd)/testerrors)

# Test ex11.sh
# Create a test folder
mkdir "ex11test" 2>> $testerrors
cd "ex11test"

cat > test1.txt << EOF
This is a text file.
It contains many words.
This is an example for simple text file.
EOF
echo -e 'This is a text file.
It contains many words. This file do not contain new line at the end!!!
This is an example for simple text file.\c' > test2.txt
cat > test3.txt << EOF
This is a WOWtextMOM file.
It contains many words texxt...
This is an example for simple text file.
EOF
cat > test4.txt << EOF
J
u
s
t

a

l
o
n10
g

f
i
l
e

w
i
t20
h

s
o
m
e

e
m
p30
t
y

l
i
n
e
s

40
EOF

cd ..
result=$(echo $(bash ex11.sh ex11test/test1.txt text))
if [[ $result != "1 5 3 8" ]]; then
	echo "Failed test 1 ex11"
	echo "Failed test 1 ex11" >> $testresult
	echo "Should be: 1 5 3 8" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex11.sh ex11test/test2.txt text))
if [[ $result != "1 5 3 8" ]]; then
	echo "Failed test 2 ex11"
	echo "Failed test 2 ex11" >> $testresult
	echo "Should be: 1 5 3 8" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex11.sh ex11test/test3.txt text))
if [[ $result != "3 8" ]]; then
	echo "Failed test 3 ex11"
	echo "Failed test 3 ex11" >> $testresult
	echo "Should be: 3 8" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex11.sh ex11test/test4.txt e))
if [[ $result != "16 1 26 1 28 1 37 1" ]]; then
	echo "Failed test 2 ex11"
	echo "Failed test 2 ex11" >> $testresult
	echo "Should be: 16 1 26 1 28 1 37 1" >> $testresult
	echo "Got: $result" >> $testresult
fi


# Test ex12.sh
# Create a test folder
mkdir "ex12test" 2>> $testerrors
cd "ex12test"

mkdir test1 2>> $testerrors
cat > test1/ex.c << EOF
This is a c file.
EOF
# Empty directory
mkdir test1/ex2 2>> $testerrors
# This one will be empty - Just for the test :)
touch test1/file.txt
cat > test1/boo.txt << EOF
This is a txt file.
EOF
cat > test1/boo2.txt << EOF
This is a txt file.
EOF
mkdir test1/video 2>> $testerrors
touch ./test1/video/vid.txt


cd ..
result=$(echo $(bash ex12.sh ex12test/test1/ ))
if [[ $result != "1 boo.txt is a file 2 boo2.txt is a file 3 file.txt is a file 4 ex2 is a directory 5 video is a directory" ]]; then
	echo "Failed test 1 ex12"
	echo "Failed test 1 ex12" >> $testresult
	echo "Should be: 1 boo.txt is a file 2 boo2.txt is a file 3 file.txt is a file 4 ex2 is a directory 5 video is a directory" >> $testresult
	echo "Got: $result" >> $testresult
fi


# Test ex13.sh
# Create a test folder
mkdir "ex13test" 2>> $testerrors
cd "ex13test"

mkdir test1 2>> $testerrors
cat > test1/a.txt << EOF
File a
EOF
cat > test1/c.txt << EOF
File c
EOF
mkdir test1/b 2>> $testerrors
cat > test1/b/a.txt << EOF
File a inside b
EOF
cat > test1/b/b.txt << EOF
File b inside b
EOF

mkdir test2 2>> $testerrors
cat > test2/b.txt << EOF
File b
EOF
cat > test2/c.txt << EOF
File c
EOF
mkdir test2/a 2>> $testerrors
cat > test2/a/a.txt << EOF
File a inside a
EOF
cat > test2/a/b.txt << EOF
File b inside a
EOF

mkdir "test3" 2>> $testerrors
cat > "test3"/b.txt << EOF
File b
EOF
cat > "test3"/c.txt << EOF
File c
EOF
mkdir "test3"/a 2>> $testerrors
cat > "test3"/a/a.txt << EOF
File a inside a
EOF
cat > "test3"/a/b.txt << EOF
File b inside a
EOF

rm -r test4 2>> $testerrors
mkdir test4 2>> $testerrors
cat > test4/ccc << EOF
File c
EOF
mkdir test4/bbb 2>> $testerrors
mkdir test4/bbb/bbb 2>> $testerrors
cat > test4/bbb/no << EOF
File no inside b
EOF

mkdir test5 2>> $testerrors
cat > test5/hello.txt << EOF
File hello
EOF
cat > test5/hello.tx << EOF
File hell
EOF
cat > test5/ello.txt << EOF
File ello
EOF
cat > test5/hhello.txt << EOF
File hhello
EOF
cat > test5/hello.txtt << EOF
File hellot
EOF

cd ..
result=$(echo $(bash ex13.sh ex13test/test1 a.txt))
if [[ $result != "File a File a inside b" ]]; then
	echo "Failed test 1 ex13"
	echo "Failed test 1 ex13" >> $testresult
	echo "Should be: File a File a inside b" >> $testresult
	echo "Got: $result" >> $testresult

fi
result=$(echo $(bash ex13.sh ex13test/test2 b.txt))
if [[ $result != "File b inside a File b" ]]; then
	echo "Failed test 2 ex13"
	echo "Failed test 2 ex13" >> $testresult
	echo "Should be: File b inside a File b" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex13.sh ex13test/test3 b.txt))
if [[ $result != "File b inside a File b" ]]; then
	echo "Failed test 3 ex13"
	echo "Failed test 3 ex13" >> $testresult
	echo "Should be: File b inside a File b" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex13.sh ex13test/test4 bbb))
if [[ $result != "" ]]; then
	echo "Failed test 4 ex13"
	echo "Failed test 4 ex13" >> $testresult
	echo "Should be: " >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex13.sh ex13test/test5 hello.txt))
if [[ $result != "File hello" ]]; then
	echo "Failed test 5 ex13"
	echo "Failed test 5 ex13" >> $testresult
	echo "Should be: File hello" >> $testresult
	echo "Got: $result" >> $testresult
fi


# Test ex14.sh
# Create a test folder
mkdir "ex14test" 2>> $testerrors
cd "ex14test"

cat > Bank-log << EOF
Dan 5000 Ramat-Aviv 1/1/1998 10:34
Dudu 10000 Herzliya-Pituah 1/1/1998 11:22
Haim 20000 Jerusalem 1/1/1998 15:18
Boris -1000 Technion 1/1/1998 17:11
Dan 3000 Ramat-Aviv 14/1/1998 10:34
Dudu 11000 Herziliya-Pituah 15/1/1998 13:21
Haim 18000 Jerusalem 15/1/1998 16:11
Boris -2000 Technion 16/1/1998 11:13
EOF
cat > Bank-log2 << EOF
Dan -5000 Ramat-Aviv 1/1/1998 10:34
HaimK 18001 Jerusalem 15/1/1998 16:11
AHaim 18012 Jerusalem 15/1/1998 16:11
IHaveAVeryVeryVeryLongNameAndFamilyName 1 Jerusalem 15/1/1998 16:11
Dudu 1234567 Herzliya-Pituah 1/1/1998 11:22
IHaveAVeryVeryVeryLongNameAndFamilyName 12 Jerusalem 15/1/1998 16:11
IHaveAVeryVeryVeryLongNameAndFamilyName 123 Jerusalem 1/1/1998 15:18
Boris 2000 Technion 1/1/1998 17:11
Dan 3000 Ramat-Aviv 14/1/1998 10:34
Dudu 7654321 Herziliya-Pituah 15/1/1998 13:21
IHaveAVeryVeryVeryLongNameAndFamilyName 1234 Jerusalem 15/1/1998 16:11
Boris -2000 Technion 16/1/1998 11:13
Haim 18002 Jerusalem 15/1/1998 16:11
Haim 18003 Jerusalem 15/1/1998 16:11
HaimK 18000 Jerusalem 15/1/1998 16:11
EOF

cd ..
result=$(echo $(bash ex14.sh "Haim" ex14test/Bank-log))
if [[ $result != "Haim 20000 Jerusalem 1/1/1998 15:18 Haim 18000 Jerusalem 15/1/1998 16:11 Total balance: 38000" ]]; then
	echo "Failed test 1 ex14"
	echo "Failed test 1 ex14" >> $testresult
	echo "Should be: Haim 20000 Jerusalem 1/1/1998 15:18 Haim 18000 Jerusalem 15/1/1998 16:11 Total balance: 38000" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex14.sh "Boris" ex14test/Bank-log))
if [[ $result != "Boris -1000 Technion 1/1/1998 17:11 Boris -2000 Technion 16/1/1998 11:13 Total balance: -3000" ]]; then
	echo "Failed test 2 ex14"
	echo "Failed test 2 ex14" >> $testresult
	echo "Should be: Boris -1000 Technion 1/1/1998 17:11 Boris -2000 Technion 16/1/1998 11:13 Total balance: -3000" >> $testresult
	echo "Got: $result" >> $testresult
fi

result=$(echo $(bash ex14.sh "Dan" ex14test/Bank-log2))
if [[ $result != "Dan -5000 Ramat-Aviv 1/1/1998 10:34 Dan 3000 Ramat-Aviv 14/1/1998 10:34 Total balance: -2000" ]]; then
	echo "Failed test 3 ex14"
	echo "Failed test 3 ex14" >> $testresult
	echo "Should be: Dan -5000 Ramat-Aviv 1/1/1998 10:34 Dan 3000 Ramat-Aviv 14/1/1998 10:34 Total balance: -2000" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex14.sh "IHaveAVeryVeryVeryLongNameAndFamilyName" ex14test/Bank-log2))
if [[ $result != "IHaveAVeryVeryVeryLongNameAndFamilyName 1 Jerusalem 15/1/1998 16:11 IHaveAVeryVeryVeryLongNameAndFamilyName 12 Jerusalem 15/1/1998 16:11 IHaveAVeryVeryVeryLongNameAndFamilyName 123 Jerusalem 1/1/1998 15:18 IHaveAVeryVeryVeryLongNameAndFamilyName 1234 Jerusalem 15/1/1998 16:11 Total balance: 1370" ]]; then
	echo "Failed test 4 ex14"
	echo "Failed test 4 ex14" >> $testresult
	echo "Should be: IHaveAVeryVeryVeryLongNameAndFamilyName 1 Jerusalem 15/1/1998 16:11 IHaveAVeryVeryVeryLongNameAndFamilyName 12 Jerusalem 15/1/1998 16:11 IHaveAVeryVeryVeryLongNameAndFamilyName 123 Jerusalem 1/1/1998 15:18 IHaveAVeryVeryVeryLongNameAndFamilyName 1234 Jerusalem 15/1/1998 16:11 Total balance: 1370" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex14.sh "Dudu" ex14test/Bank-log2))
if [[ $result != "Dudu 1234567 Herzliya-Pituah 1/1/1998 11:22 Dudu 7654321 Herziliya-Pituah 15/1/1998 13:21 Total balance: 8888888" ]]; then
	echo "Failed test 5 ex14"
	echo "Failed test 5 ex14" >> $testresult
	echo "Should be: Dudu 1234567 Herzliya-Pituah 1/1/1998 11:22 Dudu 7654321 Herziliya-Pituah 15/1/1998 13:21 Total balance: 8888888" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex14.sh "Boris" ex14test/Bank-log2))
if [[ $result != "Boris 2000 Technion 1/1/1998 17:11 Boris -2000 Technion 16/1/1998 11:13 Total balance: 0" ]]; then
	echo "Failed test 6 ex14"
	echo "Failed test 6 ex14" >> $testresult
	echo "Should be: Boris 2000 Technion 1/1/1998 17:11 Boris -2000 Technion 16/1/1998 11:13 Total balance: 0" >> $testresult
	echo "Got: $result" >> $testresult
fi
result=$(echo $(bash ex14.sh "Haim" ex14test/Bank-log2))
if [[ $result != "Haim 18002 Jerusalem 15/1/1998 16:11 Haim 18003 Jerusalem 15/1/1998 16:11 Total balance: 36005" ]]; then
	echo "Failed test 7 ex14"
	echo "Failed test 7 ex14" >> $testresult
	echo "Should be: Haim 18002 Jerusalem 15/1/1998 16:11 Haim 18003 Jerusalem 15/1/1998 16:11 Total balance: 36005" >> $testresult
	echo "Got: $result" >> $testresult
fi



if [[ -z $(cat $testresult) ]]; then
	echo "All tests passed!"
	echo "All tests passed!" > $testresult
fi


# Tests by YonLif

