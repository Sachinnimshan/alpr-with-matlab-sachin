dbname='lprs';
username='root';
password='';
driver='com.mysql.jdbc.Driver';
dburl=['jdbc:mysql://localhost:3306/',dbname];
javaclasspath('C:\Program Files\MATLAB\MATLAB Production Server\R2015a\java\jarext/mysql-connector-java-5.1.6-bin.jar');

conn=database(dbname,username,password,driver,dburl);

%colnames={'User_ID' 'Name' 'Username' 'Password'};
%data={'UI002' 'Sachin' 'Sachin' 'Sachin'};
%datainsert(conn,'login',colnames,data)

extplateno = 'ELH2255';
sqlquery = ['SELECT * FROM registration WHERE Plate_Number =' '''' extplateno ''''];
curs = exec(conn,sqlquery);
curs = fetch(curs);
numrows = rows(curs);
if numrows == 0
disp('Not Allowed')
else
disp('Parking Allocated')
end
    