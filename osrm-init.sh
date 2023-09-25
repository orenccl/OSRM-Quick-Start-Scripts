wget http://download.geofabrik.de/asia/taiwan-latest.osm.pbf

mkdir osrm-cycling osrm-driving osrm-walking

cp taiwan-latest.osm.pbf osrm-cycling
cp taiwan-latest.osm.pbf osrm-driving
cp taiwan-latest.osm.pbf osrm-walking

podman run --rm -v $(pwd)/osrm-cycling:/data osrm/osrm-backend osrm-extract -p /opt/bicycle.lua /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-cycling:/data osrm/osrm-backend osrm-partition /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-cycling:/data osrm/osrm-backend osrm-customize /data/taiwan-latest.osm.pbf

podman run --rm -v $(pwd)/osrm-driving:/data osrm/osrm-backend osrm-extract -p /opt/car.lua /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-driving:/data osrm/osrm-backend osrm-partition /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-driving:/data osrm/osrm-backend osrm-customize /data/taiwan-latest.osm.pbf

podman run --rm -v $(pwd)/osrm-walking:/data osrm/osrm-backend osrm-extract -p /opt/foot.lua /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-walking:/data osrm/osrm-backend osrm-partition /data/taiwan-latest.osm.pbf
podman run --rm -v $(pwd)/osrm-walking:/data osrm/osrm-backend osrm-customize /data/taiwan-latest.osm.pbf