#!/bin/bash
addgroup learning
if [ ! -f /usr/local/lib/middle_earth/middle_earth.db ]; then
  echo "La base de datos $DATABASE_NAME no existe. Creandola..."

  mkdir -p /usr/local/lib/middle_earth
  chgrp learning /usr/local/lib/middle_earth
  chmod 775 /usr/local/lib/middle_earth

  sqlite3 /usr/local/lib/middle_earth/middle_earth.db < /root/middle_earth.sql
  chgrp learning /usr/local/lib/middle_earth/middle_earth.db
  chmod 664 /usr/local/lib/middle_earth/middle_earth.db
else
  echo "La base de datos $DATABASE_NAME ya existe. No se crear.. nuevamente."
fi

/usr/local/bin/middle_earth/create_environment
