AWK=$(cat <<EOF

BEGIN {
    unit["Bytes"] = 1;

    unit["kB"] = 10**3;
    unit["MB"] = 10**6;
    unit["GB"] = 10**9;
    unit["TB"] = 10**12;
    unit["PB"] = 10**15;
    unit["EB"] = 10**18;
    unit["ZB"] = 10**21;
    unit["YB"] = 10**24;

    unit["KB"] = 1024;
    unit["KiB"] = 1024**1;
    unit["MiB"] = 1024**2;
    unit["GiB"] = 1024**3;
    unit["TiB"] = 1024**4;
    unit["PiB"] = 1024**5;
    unit["EiB"] = 1024**6;
    unit["ZiB"] = 1024**7;
    unit["YiB"] = 1024**8;
}

{
    if(\$2 in unit) total += \$1 * unit[\$2];
    else printf("ERROR: Can't decode unit at line %d: %s\n", NR, \$0);
}

END {
    binaryunits[0] = "Bytes";
    binaryunits[1] = "KiB";
    binaryunits[2] = "MiB";
    binaryunits[3] = "GiB";
    binaryunits[4] = "TiB";
    binaryunits[5] = "PiB";
    binaryunits[6] = "EiB";
    binaryunits[7] = "ZiB";
    binaryunits[8] = "YiB";
    for(i = 8;; --i) {
         if(total >= 1024**i || i == 0) {
            printf("%.2f %s\n", total/(1024**i), binaryunits[i]);
            break;
        }
    }
}

EOF
)


SIZE=$(docker stats --no-stream --format "table {{.MemUsage}}" | tail -n +2 | cut -d/ -f1 | sed -E "s/([[:digit:]]+)([[:alpha:]]+)/\1 \2/" | awk "${AWK}")

echo ""
docker stats --no-stream
echo ""
echo "Total Memory Usage: $SIZE"
echo ""
