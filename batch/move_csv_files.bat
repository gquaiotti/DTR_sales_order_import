cd\
net use k: \\10.144.8.14\datatrax /user:brprodapp-totvs\brprodapp "L3mon123!"
k:
cd import
cd 01
forfiles /m *.csv /c "cmd /c move @path D:\DATATRAX\xml\02\import\"
cd ..
cd 02 
forfiles /m *.csv /c "cmd /c move @path D:\DATATRAX\xml\02\import\"
c:
net use k: /d
exit /b