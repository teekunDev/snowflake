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
- manually set cpu topology: 1, 6, 2
- add this below <vcpu ...>

```
  <cputune>
    <vcpupin vcpu='0' cpuset='2' />
    <vcpupin vcpu='1' cpuset='3' />
    <vcpupin vcpu='2' cpuset='4' />
    <vcpupin vcpu='3' cpuset='5' />
    <vcpupin vcpu='4' cpuset='6' />
    <vcpupin vcpu='5' cpuset='7' />
    <vcpupin vcpu='6' cpuset='10' />
    <vcpupin vcpu='7' cpuset='11' />
    <vcpupin vcpu='8' cpuset='12' />
    <vcpupin vcpu='9' cpuset='13' />
    <vcpupin vcpu='10' cpuset='14' />
    <vcpupin vcpu='11' cpuset='15' />
  </cputune>
```

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
- add ssd /dev/disk/by-label/Games

- cpu isolation
  `sudo mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/`  
  `sudo nano /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/isolstart.sh`

```
systemctl set-property --runtime -- user.slice AllowedCPUs=0,1,8,9
systemctl set-property --runtime -- system.slice AllowedCPUs=0,1,8,9
systemctl set-property --runtime -- init.scope AllowedCPUs=0,1,8,9
```

`sudo mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/release/end/`  
 `sudo nano /var/lib/libvirt/hooks/qemu.d/win11/release/end/isocpurevert.sh`

```
systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
```
