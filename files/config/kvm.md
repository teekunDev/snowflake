# sudo virsh net-autostart default & sudo virsh net-start default

# looking glass permissions

> sudo nano /etc/tmpfiles.d/10-looking-glass.conf

```
# Type Path               Mode UID  GID Age Argument

f /dev/shm/looking-glass 0660 keifufu libvirtd -
```

# vm setup

- new vm: manual: win11: select existing .qcow2

- vCpu allocation: 12

- memory: 16384

- add this under <devices>

```xml
<shmem name='looking-glass'>
  <model type='ivshmem-plain'/>
  <size unit='M'>32</size>
</shmem>
```

- change video to VGA
- remove tablet inputs
- replace bus=ps2 in mouse and keyboard with bus=virtio
- replace sound

```xml
<sound model='ich9'>
  <audio id='1'/>
</sound>
```

- add pci devices
