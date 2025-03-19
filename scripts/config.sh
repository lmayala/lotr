#TODO
#Check supervisor is running before proceeding
MYSQL_ROOT_PASSWORD=root
DATABASE_NAME=middle_earth
echo "Esperando a que MariaDB este disponible..."
until mariadb -h"localhost" -u root -p$MYSQL_ROOT_PASSWORD -e "SELECT 1;" > /dev/null 2>&1; do
    sleep 1
done
echo "MariaDB esta listo"


if ! mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "USE $DATABASE_NAME;" 2>/dev/null; then

  echo "La base de datos $DATABASE_NAME no existe. Creandola..."
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'%' IDENTIFIED BY 'root'";
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'";
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "create database middle_earth;"
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "grant all on middle_earth.* to root@'%' identified by 'root';"
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "grant all on middle_earth.* to root@'localhost' identified by 'root';"
  mariadb -u root -p$MYSQL_ROOT_PASSWORD middle_earth -e "flush privileges;"
  mariadb -u root -p$MYSQL_ROOT_PASSWORD middle_earth < /root/middle_earth.sql
  mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"
else
  echo "La base de datos $DATABASE_NAME ya existe. No se crear.. nuevamente."
fi

/usr/local/bin/middle_earth/create_environment
