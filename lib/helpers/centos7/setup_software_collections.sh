activate_scl() {
  source /opt/rh/rh-php73/enable
  source /opt/rh/rh-nginx116/enable
  cat <<EOF > /etc/profile.d/passbolt_scl.sh
#!/bin/bash
source scl_source enable rh-php73
source scl_source enable rh-nginx116
EOF
}
