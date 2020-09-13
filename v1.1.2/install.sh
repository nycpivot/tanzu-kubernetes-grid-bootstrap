curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu

wget https://tanzufiles.blob.core.windows.net/tkg/tkg-linux-amd64-v1.1.2-vmware.1.gz
gunzip tkg-linux-amd64-v1.1.2-vmware.1.gz
sudo mv tkg-linux-amd64-v1.1.2-vmware.1 /usr/local/bin/tkg
chmod +x /usr/local/bin/tkg

sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

"yes" | sudo apt install jq

wget https://tanzufiles.blob.core.windows.net/tkg/clusterawsadm-linux-amd64-v0.5.4-vmware-1.gz
gunzip clusterawsadm-linux-amd64-v0.5.4-vmware-1.gz
sudo mv clusterawsadm-linux-amd64-v0.5.4-vmware-1 /usr/local/bin/clusterawsadm
chmod +x /usr/local/bin/clusterawsadm




aws cloudformation delete-stack --stack-name cluster-api-provider-aws-sigs-k8s-io
aws iam delete-user --user-name bootstrapper.cluster-api-provider-aws.sigs.k8s.io
clusterawsadm alpha bootstrap create-stack

aws ec2 delete-key-pair --key-name default
aws ec2 create-key-pair --key-name default --output json | jq .KeyMaterial -r > default.pem

