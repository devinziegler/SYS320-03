#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function courseLocation () {
	echo -n "Please Input a location to search for courses "
	read classLoc

	echo ""
	echo "Courses of $classLoc :"
	cat "$courseFile" | grep "$classLoc" | cut -d';' -f1,2,5,6,7 | \
	sed 's/;/ | /g'
	echo ""

}



# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function availCourses () {
	echo -n "Please Input a Course Number to Search of Open Seats"
	read courseCode

	echo ""
	echo "Courses from $courseCode : with open seats"
	cat "$courseFile" | grep "$courseCode" | awk -F\; '{if($4>0)print $0}' | \
	sed 's/;/ | /g'
	echo "" 

}



while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display course by Location"
	echo "[4] Display open seats by Course"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		courseLocation

	elif [[ "$userInput" == "4" ]]; then
		availCourses

	# TODO - 3 Display a message, if an invalid input is given
	
	elif [[ "$userInput" =~ ^[1-7]+$ ]]; then
		echo "Please Enter a valid option [1-5]"

	
	fi
done
