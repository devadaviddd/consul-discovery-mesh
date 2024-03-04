# docker exec -it consol-server bash -c "
#   sudo mv /etc/consul.d/consul.hcl /etc/consul.d/consul.hcl.back
# "
# docker cp consul.hcl consol-server:/etc/consul.d/consul.hcl
# docker exec -it consol-server bash -c "
#   sudo consul agent -dev -config-dir /etc/consul.d/ &
# "

sudo cp /etc/consul.d/consul.hcl /etc/consul.d/consul.hcl.back
sudo consul agent -dev -config-dir /etc/consul.d/ &
tail -f /dev/null