CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

submittedFile=`find student-submission -name "ListExamples.java"`
echo $submittedFile

if [[ "$submittedFile" =~ "ListExamples.java" ]]; then
    echo "Correct file submitted!"
else
    echo "Incorrect file submitted."
    exit 1
fi

cp *.java grading-area/
cp $submittedFile grading-area/
cp lib/* grading-area/

javac -classpath grading-area/\* grading-area/*.java

cd grading-area
java -cp ".;junit-4.13.2.jar;hamcrest-core-1.3.jar;/*.java" org.junit.runner.JUnitCore TestListExamples > JUnitOutput.txt

fail=`grep "FAIL" JUnitOutput.txt`

if [ "$fail" = "FAILURES!!!" ]; then
    echo "Not all tests pass, FAIL."
    exit 1
else
    echo "All tests pass, PASS."
    exit 0
fi