#!/bin/bash
DATA=`date -I`
TIME=`date "+%Y%m%d %H:%M:%S"`
DES=/www/backup/mysql
LOG=/www/backup/backup.log
MYSQL_USER=root
MYSQL_PASSWORD="xxxxx"
if [ ! -d "$DES" ] ; then
        mkdir -p "$DES"
fi

DB=$(mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -Bse 'show databases' | egrep -v "mysql|information_schema|performance_schema")

for database in $DB
        do
                mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" $database --lock-all-tables --flush-logs > $DES/"${DATA}"_"$database".sql

        done

if [ $? -eq 0 ]
then
        echo "[$TIME] mysqlbackup secuess" >> $LOG
else
        echo "[$TIME] mysqlbackup error" >> $LOG
fi
