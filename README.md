# docker-systemd-jammy

Simple way to run apps using systemd inside jammy container

## How to run?
````
cd /opt
git clone https://github.com/primoitt83/docker-systemd-jammy.git
cd docker-systemd-jammy
docker-compose up -d
````
Check the logs:

````
docker-compose logs -f --tail=100

systemd  | [  OK  ] Mounted Arbitrary Executable File Formats File System.
systemd  |          Starting Flush Journal to Persistent Storage...
systemd  | [  OK  ] Finished Set Up Additional Binary Formats.
systemd  | [  OK  ] Finished Flush Journal to Persistent Storage.
systemd  |          Starting Create Volatile Files and Directories...
systemd  | [  OK  ] Finished Create Volatile Files and Directories.
systemd  |          Starting Network Name Resolution...
systemd  | [  OK  ] Reached target System Time Set.
systemd  |          Starting Record System Boot/Shutdown in UTMP...
systemd  | [  OK  ] Finished Record System Boot/Shutdown in UTMP.
systemd  | [  OK  ] Reached target System Initialization.
systemd  | [  OK  ] Started Daily apt download activities.
systemd  | [  OK  ] Started Daily apt upgrade and clean activities.
systemd  | [  OK  ] Started Daily dpkg database backup timer.
systemd  | [  OK  ] Started Periodic ext4 Onli…ata Check for All Filesystems.
systemd  | [  OK  ] Started Message of the Day.
systemd  | [  OK  ] Started Daily Cleanup of Temporary Directories.
systemd  | [  OK  ] Reached target Basic System.
systemd  | [  OK  ] Reached target Timer Units.
systemd  | [  OK  ] Listening on D-Bus System Message Bus Socket.
systemd  | [  OK  ] Started D-Bus System Message Bus.
systemd  |          Starting Remove Stale Onli…t4 Metadata Check Snapshots...
systemd  |          Starting Dispatcher daemon for systemd-networkd...
systemd  |          Starting User Login Management...
systemd  |          Starting Permit User Sessions...
systemd  | [  OK  ] Finished Permit User Sessions.
systemd  | [  OK  ] Started Console Getty.
systemd  | [  OK  ] Started Getty on tty1.
systemd  | [  OK  ] Reached target Login Prompts.
systemd  | [  OK  ] Started Network Name Resolution.
systemd  | [  OK  ] Reached target Host and Network Name Lookups.
systemd  | [  OK  ] Finished Remove Stale Onli…ext4 Metadata Check Snapshots.
systemd  | [  OK  ] Started Dispatcher daemon for systemd-networkd.
systemd  | [  OK  ] Started User Login Management.
systemd  | [  OK  ] Reached target Multi-User System.
systemd  | [  OK  ] Reached target Graphical Interface.
systemd  |          Starting Record Runlevel Change in UTMP...
systemd  | [  OK  ] Finished Record Runlevel Change in UTMP.
systemd  | 
systemd  | Ubuntu 22.04.4 LTS ub-22-04 console
systemd  |
````

Now go to container and test your apps:
````
docker-compose exec systemd /bin/bash
````

## cgroup v1

If you need this folder located here:
````
/sys/fs/cgroup
````

You will need to enable cgroup v1 first. 

More details on link:

https://github.com/moby/moby/issues/42275#issuecomment-1115041405

## Enable cgroup v1

This is for Ubuntu Jammy host:

````
vim /etc/default/grub
````
Find these lines:
````
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX=""
````

Modify to:
````
GRUB_CMDLINE_LINUX_DEFAULT="quiet systemd.unified_cgroup_hierarchy=0"
GRUB_CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=0"
````
````
update-grub

reboot
````

Now you can start compose using my another yaml file:
````
cd /opt/docker-systemd-jammy
docker-compose down
docker-compose -f docker-compose.vol.yml up -d
````
Check volume inside the container:
````
docker-compose exec systemd /bin/bash
````
````
df -h
Filesystem      Size  Used Avail Use% Mounted on
overlay          49G   31G   16G  68% /
tmpfs            64M     0   64M   0% /dev
shm              64M     0   64M   0% /dev/shm
/dev/sda2        49G   31G   16G  68% /etc/hosts
tmpfs           4.0M     0  4.0M   0% /sys/fs/cgroup
tmpfs           779M   40K  779M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
````





