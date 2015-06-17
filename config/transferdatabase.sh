#!/bin/sh
OF=transition-$(date +%Y%m%d).db
pg_dump --username=cayuse rubyorder_development > $OF;
dropdb --username=cayuse rubyorder_production;
createdb --username=cayuse rubyorder_development;
psql --username=cayuse rubyorder_production -f $OF;
cp $OF db.back;
echo "Don't Forget to Copy the db file $OF."
#svn commit -m "db store";
