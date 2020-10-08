echo "Avatansh Awasthi"
echo "1947208"
echo ""
echo "Program to demonstrate calculation of total salary of an employee  after taking details..."
echo ""

echo "Enter details of the employees."
echo ""
echo "Press 1 to enter details otherwise 0 to skip entering"
read ch
while [ $ch -eq 1 ]
do
	echo "Enter name of the employee : "
	read name
	flag=1

	echo "entering details of : " $name | tr "[:lower:]" "[:upper:]" # usage of "tr' command

	while [ $flag -eq 1 ]
	do
		echo "Enter the employees id(int) : "
		read id
		if ! [[ "$id" =~ ^[0-9]+$ ]]
		then
			echo "Employees id must be an integer."
			flag=1
		else
			flag=0
		fi
	done

	echo "Enter department : "
	read dept
	echo "Enter designation : "
	read desig

	flag=1
	while [ $flag -eq 1 ]
	do
		echo "Enter Basic-pay(float)"
		read bpay
		if ! [[ "$bpay" =~ ^[0-9]*[.][0-9]*$ ]]
		then
			echo "Basic-pay must be a float."
			flag=1
		else
			flag=0
		fi
	done

	echo $name $id $dept $desig $bpay >> emp_details.txt
	echo "Press 1(true) to add more employees otherwise press 0(false)"
	read ch
done

echo "Press 1 to see details of an employee any other key to exit."
read n
choice=1
while [ $choice -eq 1 ]
do

if [ $n -eq 1 ]
then
	echo "Enter the employee id : "
	read eid

	awk -v empid=$eid '{
	if ($2 == empid)
	{
		print "Details of employee with id ",empid
		print "Name\t\t: ",$1
		print "Department\t: ",$3
		print "Designation\t: ",$4

		printf "Basic pay\t: %.2f\n",$5

		da=$5 * 0.45 #da is 45% of basic pay
		printf "DA\t\t: %.2f\n",da

		hra=$5 * .12 # hra is 12% of basic pay
		printf "HRA\t\t: %.2f\n",hra

		cca=400      # cca is fixed 400
		printf "CCA\t\t: %.2f\n",cca

		gp=$5+da+hra+cca # gross pay
		printf "GP\t\t: %.2f\n",gp

		ap=gp * 12  # annual pay
		printf "AP\t\t: %.2f\n",ap

		pf=$5 * .25 # provident fund
		printf "PF\t\t: %.2f\n",pf


		if (ap <= 60000)
			it=0.0;
		else if(ap <= 120000)
			it=.1 * gp;
		else if(ap <= 180000)
			it=.2 * gp;
		else
			it=.25 * gp;

		np=gp - pf - it #net pay
		printf "NP\t\t: %.2f\n",np

		tot=$5 + da + hra + cca + gp + ap + pf + np
		printf "Total Salary of the employee is\t: %.2f\n",tot
		exit 1
		}
	}' emp_details.txt

	if [ $? -ne 1 ]
	then
		echo "Invalid ID"
	fi
fi
echo "Press 0 to exit otherwise 1 to display details of another employee..."
read choice
done
