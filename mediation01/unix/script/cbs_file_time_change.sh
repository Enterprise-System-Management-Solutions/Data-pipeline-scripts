
#!/bin/sh
cd /data02/cbs/20200609/
for i in *mon*; do
  touch -r "$i" -d '-21 hour' "$i"
done

