Access `http://<Cloudera Manager Host>:7180/cmf/parcel/status` and add the following remote parcel repository URL in Parcel Settings.

```
https://raw.githubusercontent.com/ichiro-arai/cm-livy-scripts/useradd-parcel/parcels/
```

The registered files are generated by the following commands:

```
cd ..
./build_parcel.sh USERADD-1.0 el7
```