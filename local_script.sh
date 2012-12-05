#!/usr/bin/bash
DB_PWD="$1"
BACKUP_DIR="$2"
COMPRESSED_FILE="$3"
rm "$COMPRESSED_FILE"

mkdir -p "$BACKUP_DIR"

process_item () {
  echo "Backing up '$1'..."
  DESTINATION_FOLDER="$BACKUP_DIR/$1"
  mkdir -p "$DESTINATION_FOLDER"
  if [[ $2 ]]
  then
    FILES_FOLDER="$DESTINATION_FOLDER/files"
    mkdir -p "$FILES_FOLDER"
    cp -rp "$2" "$FILES_FOLDER"
  fi

  if [[ $3 ]]
  then
    SQL_FOLDER="$DESTINATION_FOLDER/sql"
  	mkdir -p "$SQL_FOLDER"
    db_file="$SQL_FOLDER/$3.sql"
    mysqldump -uroot -p"$DB_PWD" "$3" > "$db_file"
  fi
}

process_item "just_folder" "/etc/apache2"
process_item "folder_and_db" "/var/www/dummy" "dummydb"
process_item "just_db" "" "foo_db"
echo "$BACKUP_DIR"

tar -zcf "$COMPRESSED_FILE" "$BACKUP_DIR"
rm -rf "$BACKUP_DIR"
