#!/bin/bash

set -e

echo " 🚀 Installing Tomcat 9 manually"

# 1. Update system and install dependencies
sudo apt update -y
sudo apt install -y openjdk-17-jre-headless wget unzip -y

# 2. Download Tomcat 9 zip
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.111/bin/apache-tomcat-9.0.111.zip

# 3. Unzip Tomcat
unzip apache-tomcat-9.0.111.zip

# 4. Rename extracted folder to 'tomcat9'
mv apache-tomcat-9.0.111 /home/ubuntu/tomcat9

# 5. Make scripts executable
chmod +x /home/ubuntu/tomcat9/bin/*.sh

# 6. Configure deploy/admin users
cat >> /home/ubuntu/tomcat9/conf/tomcat-users.xml <<EOF
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <user username="tomcat" password="tomcat" roles="manager-gui,manager-script"/>
  <user username="admin" password="admin" roles="manager-gui"/>
  <user username="robot" password="robot" roles="manager-script"/>
</tomcat-users>
EOF

# 7. Disable RemoteAddrValve in manager context
sed -i 's#<Valve className="org.apache.catalina.valves.RemoteAddrValve".*#<!-- & -->#' /home/ubuntu/tomcat9/webapps/manager/META-INF/context.xml

# 8. Disable RemoteAddrValve in host-manager context
sed -i 's#<Valve className="org.apache.catalina.valves.RemoteAddrValve".*#<!-- & -->#' /home/ubuntu/tomcat9/webapps/host-manager/META-INF/context.xml

# 9. Start Tomcat
/home/ubuntu/tomcat9/bin/startup.sh

# 10. Wait and check status
sleep 5
/home/ubuntu/tomcat9/bin/status.sh || true

echo "==============================================="
echo " ✅ Tomcat 9 installed and running!"
