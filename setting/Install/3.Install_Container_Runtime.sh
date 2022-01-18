echo step1

# install Docker runtime
# Add repo and Install packages
echo start update
sudo apt update
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo Create required directories
sudo mkdir -p /etc/systemd/system/docker.service.d

echo Create daemon json config file
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

echo Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

echo step2
echo install CRI-O
echo Ensure you load modules
sudo modprobe overlay
sudo modprobe br_netfilter

echo Set up required sysctl params
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

echo Reload sysctl
sudo sysctl --system

echo Add Cri-o repo
# sudo su - 
OS="xUbuntu_20.04"
VERSION=1.22
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -


## Execute commands directly in the current directory
echo Update CRI-O CIDR subnet
sudo sed -i 's/10.85.0.0/192.168.0.0/g' /etc/cni/net.d/100-crio-bridge.conf

echo Install CRI-O
echo start update
sudo apt update
sudo apt install cri-o cri-o-runc

echo Start and enable Service
sudo systemctl daemon-reload
sudo systemctl restart crio
sudo systemctl enable crio
# sudo systemctl status crio

echo step 3
echo install containered
echo Configure persistent loading of modules
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

echo Load at runtime
sudo modprobe overlay
sudo modprobe br_netfilter

echo Ensure sysctl params are set
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

echo Reload configs
sudo sysctl --system

echo Install required packages
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

echo Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo Install containerd
sudo apt update
sudo apt install -y containerd.io

echo Configure containerd and start service
# sudo su -
mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

echo restart containerd
sudo systemctl restart containerd
sudo systemctl enable containerd
#systemctl status  containerd

