#cloud-config

package_upgrade: true

packages:
  - git

runcmd:
  - [sh -c "ls"]
  - [sh -c "cd /root/"]
  - [sh -c "mkdir /root/test"]
  - [sh -c "cd /root/test"]
  - [sh -c "mount -t nfs 10.0.5.86:/root/.kube/ /root/test"]

users:
  - name: fedora
    gecos: fedora
    password: password
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa 
  - name: nadorr
    gecos: nadorr
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa
  - name: mjschmidt
    gecos: mjschmidt
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ssh-rsa 
