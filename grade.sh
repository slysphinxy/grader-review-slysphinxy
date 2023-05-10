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


submittedFile=`ls student-submission`
echo $submittedFile

if [ "$submittedFile" = "ListExamples.java" ]; then
    echo "Correct file submitted!"
else
    echo "Incorrect file submitted."
    exit 1
fi

cp *.java grading-area/
cp student-submission/*.java grading-area/
cp lib/* grading-area/

javac -classpath grading-area/\* grading-area/*.java
java -cp ".;grading-area/junit-4.13.2.jar;grading-area/hamcrest-core-1.3.jar;grading-area/*.java" org.junit.runner.JUnitCore grading-area/TestListExamples > grading-area/gradeResults.txt