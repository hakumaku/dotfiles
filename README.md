Always works in progress

## General directories
* `/usr/share/applications`: all the `.desktop` entries
* `/usr/share/xsessions`: login entries.
* `/usr/share/icons`: icons
* `/etc/udev/rules.d`: `udev` rules
* `/etc/hostname`: machine name
* `/etc/hosts`: hosts

## `bluetoothctl`
Managing bluetooth via command line.
General usage:
<pre>
<code>
$ bluetoothctl
$ power on
$ scan on
$ pair <em>device</em>
$ connect <em>device</em>
$ trust <em>device</em>
</code>
</pre>

## `iwctl`
Managing wifi via command line.
General usage:
<pre>
<code>
$ iwctl
$ device list
$ station <em>device</em> scan
$ station <em>device</em> get-networks
$ station <em>device</em> connect SSID
</code>
</pre>

## `xrandr`
Basic commands to configure displays.
```shell
$ xrandr --output HDMI-0 --mode 3840x2160 --rate 60
$ xrandr --output HDMI-0 --mode 3840x2160 --rate 60 --left-of HDMI-1
$ xrandr --output HDMI-0 --mode 3840x2160 --rate 60 --right-of HDMI-1
```

## `xprop`
Useful to figure out get properties of windows.
```shell
$ xprop
$ xprop | grep -i "class"
$ xprop | grep -i "name"
```

## `mkinitcpio`
The initial ramdisk is in essence a very small environment (early userspace) which loads various kernel modules and sets up necessary things before handing over control to init.
(resolving for sort of like chicken-and-egg problem)
```shell
$ sudoedit /etc/mkinitcpio.conf
$ sudo mkinitcpio -P
```

## `grub`
```shell
$ sudoedit /etc/default/grub
$ grub-mkconfig -o /boot/grub/grub.cfg "$@"
```

## Enabling wayland on gnome-shell
* Comment out the line `WaylandEnable=false` in `/etc/gdm/custom.conf` 
* Edit `/etc/mkinitcpio.conf`
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
* Apply changes
```
$ sudo mkinitcpio -P
```
* Edit `/etc/default/grub`
```
GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1"
```
* Apply changes
```
$ grub-mkconfig -o /boot/grub/grub.cfg "$@"
```
* Install packages if missing.
```shell
$ sudo pacman -Syu --needed xorg-xwayland libxcb egl-wayland
```

