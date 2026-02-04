_This project has been created as part of the 42 curriculum by jfox_
# born_2_be_root
A small repo to show the technical parts of my B2BR project.

__## DESCRIPTION__

For this project we had to set up a virtual server and save the signature of our virtual machine. 
We were tasked with creating the virtual machine with several partitions and were required to follow strict rules in the implimentation of Users, Groups, Root, SSH, Firewalls and Password security.
Finally a monitoring script was required to run with Cron to show data and system information at intervals on all devices connected to the virtual machine. 

Note, this repo holds only the README for the project. There is nothing else to show. 
The monitoring script written for this project will be added at a later date.

__## INSTRUCTIONS__

The signature.txt file is all that is required for the subject, using command "**sha1sum my_first_machine.vdi**" in the root of the virtual machine you can read this signature.
Here are some commands that will help navigating the virtual machine:
uname -a: for complete system information about the debian installation.
ufw status verbose: for checking firewall settings.
aa-status: for checking the status of Apparmor, our mandatory access control framework.
systemctl status ssh: for checking the state of ssh on the system.
cat /etc/group: to see user groups.
useradd: to add new users
groupadd: add groups.
usermod -a -G: add a user to new groups.
nano /etc/login.defs:			password config files.
nano /etc/pam.d/common-password:password config files.
hostnamectl: change the host name.
set-hostname:set the host name.
lsblk: reveal virtual machine partitians.
visudo: show sudo config.
cd /var/log/sudo: check the sudo command log.
ss -tunlp: active firewall rules for ufw.
ufw allow "port": allow traffic through a port on the firewall.
nano /etc/ssh/sshd_config: show the ssd config file.
ssh "user"@localhost -p 2222: access the virtual machine through ssh.
crontab -e see the monitoring script cron job.
nano /etc/cron.d/monitoring.sh: see the monitoring script.

The correction will take place inside the virtual machine environment so regard the subject for how to proceed.

__## RESOURCES__

AI was not used on this project.
I followed [this guide](https://github.com/chlimous/42-born2beroot_guide) to get to grips on the concept of B2BR.
I also checked [this guide](https://github.com/javfdez/Born2beRoot?tab=readme-ov-file) for additional help with understanding the monitoring script. 

__## ADDITIONAL____## PROJECT DESCRIPTION__

I began the project using Virtual Box as compared to UTM it has graphical features and from what I understand a more complete suite of tools. Also, from my reading, UTM is favoured for MAC OS and I was working on a dell with Ubuntu. 

I have written my B2BR using Debian as I believe it to be the simpler choice and as this is my first time using virtual machines it made more sense. Also Debian is the foundation of Ubuntu and so I am slightly more familiar with it. Rocky is meant to be more stable, but Debian is more easily customisable, so Debian was my clear choice. 

For the partitions, following the subject and the guides listed above I allocated 20gb of storage to allow me to carve out space for the correct partition types, /home/var/tmp.
I also was able to add 2 Logical Volumes srv and var-log and set them to EXT4 file systems to help prevent data loss. On set up of the virtual machine we ensured SSH was also included. 

As I am using debian I am also using apparmor which is a mandatory access control framework. It confines programs to a set of rules that specify what programs can access. It therefore protects against unknown or unexpected vulnerabilites. Compared to SELinux Apparmor is simpler and easier to configure vs SELinuxs more granular and stricter controls. Again this is my first server, so I chose the simpler options. 

Again, Debian comes with UFW (uncomplicated firewall) as standard which manages a netfilter to protect the system. It required little set up other than blocking inbound traffic and allowing outbound plus a portforwarding rule made in the VM to allow access through the 'correct' port 2222. On the theme of simplicity UFW is much less complicated to FirewallD which requires you to define profiles with seperate rules rather than simple rules for the whole server. 

Security policies for the VM followed those in the subject meaning:
* Password has to expire every 30 days
* The minimum number of days allowed before the modification of a password will
be set to 2.
* The user has to receive a warning message 7 days before their password expires.
* Your password must be at least 10 characters long. It must contain an uppercase
letter, a lowercase letter, and a number. Also, it must not contain more than 3
consecutive identical characters.
* The password must not include the name of the user.
* The following rule does not apply to the root password: The password must have
at least 7 characters that are not part of the former password.
* And the root password had to comply with this policy.
This was expanded by using SUDO and not allowing root access through SSH connections. 

User management was handled by installing SUDO and ensuring the main user had SUDO access. By using root user we can change and set these details by adding groups and adding users to groups. 

No services were installed other than the expected Apparmor and UFW that come with Debian. Unless you want to include the apt installs for SUDO, BC (basic calculator), lIBPAM (password quality) and systat (monitoring system information). SSH was also used. 
