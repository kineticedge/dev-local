#!/bin/bash

usage() {
  echo ""
  echo "Usage: $0 {-mm|-h} [-i=interval} datasource"
  echo ""
}

SOURCE=h

interval=""

for i in "$@"; do
  case $i in
    --middlemanager|-m|-mm)
      SOURCE="mm"
      ;;
    --historical|-h)
      SOURCE="h"
      ;;
    --interval=*|-i=*)
      interval="${i#*=}"
      ;;
    *)
      datasource=$i
      ;;
  esac
  shift
done

if [ -z "${datasource}" ]; then
  usage
  exit
fi


echo ""
echo $interval
echo ""

if [ "${SOURCE}" == "mm" ]; then 

  docker exec -it druid-middlemanager sh -c "/opt/staging/scripts/export_rt.sh ${datasource}"

#  docker exec -it druid-middlemanager sh -c 'cd /opt/staging; FILE=$(find /opt/druid/var/druid/task -name 00000.smoosh -print -quit) && java -classpath "/opt/druid/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main tools dump-segment --directory $(dirname $FILE) --out ./x.txt ${COMMAND} 2>/dev/null  && cat ./x.txt'

else

  docker exec -it druid-historical sh -c "/opt/staging/scripts/export_historical.sh ${datasource} ${interval}"
  #docker exec -it druid-historical sh -c "/opt/staging/scripts/export_historical.sh ${datasource} 2021-12-05T13:00:00.000Z"

fi







#docker run -it --rm --entrypoint '' -v "druid_shared:/opt/shared" "apache/druid:0.22.0" sh -c 'cd /tmp; FILE=$(find /opt/shared -name index.zip -print -quit) && unzip $FILE >/dev/null && java -classpath "/opt/druid/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main tools dump-segment --directory . --out ./x.txt --time-iso8601 --dump bitmaps --decompress-bitmaps 2>/dev/null  && cat ./x.txt'
#docker run -it --rm --entrypoint '' -v "druid_shared:/opt/shared" "apache/druid:0.22.0" sh -c "find /opt/shared -name index.zip  -exec xargs -L1 echo \;"
