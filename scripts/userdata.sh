  #!/bin/bash
  echo 'Este es el mensaje' > ~/mensaje.txt  
  yum update -y
  yum install httpd -y
  systemctl enable httpd
  systemctl start httpd

