#!/bin/sh
# get a list of the busybox applets bedrock users

rm -r /tmp/get-bb* 2>/dev/null
cd ..
cp -rp bedrocklinux-userland /tmp/get-bb-cmds-temp
cd /tmp/get-bb-cmds-temp/
make clean 1>/dev/null 2>/dev/null
make remove-unnecessary 1>/dev/null 2>/dev/null
rm get-bb-cmds.sh
find . -type f -exec awk '{for(i=1;i<=NF;i++){words[$i]++}}END{for(word in words){print word}}' > /tmp/get-bb-words {} \;
sed 's/[^a-zA-Z0-9]/\n/g' /tmp/get-bb-words | sort | uniq > /tmp/get-bb-words-2

cat > /tmp/get-bb-busyboxapplets <<EOF
[, [[, acpid, addgroup, adduser, adjtimex, ar, arp, arping, ash,
awk, basename, beep, blkid, brctl, bunzip2, bzcat, bzip2, cal, cat,
catv, chat, chattr, chgrp, chmod, chown, chpasswd, chpst, chroot,
chrt, chvt, cksum, clear, cmp, comm, cp, cpio, crond, crontab,
cryptpw, cut, date, dc, dd, deallocvt, delgroup, deluser, depmod,
devmem, df, dhcprelay, diff, dirname, dmesg, dnsd, dnsdomainname,
dos2unix, dpkg, du, dumpkmap, dumpleases, echo, ed, egrep, eject,
env, envdir, envuidgid, expand, expr, fakeidentd, false, fbset,
fbsplash, fdflush, fdformat, fdisk, fgrep, find, findfs, flash_lock,
flash_unlock, fold, free, freeramdisk, fsck, fsck.minix, fsync,
ftpd, ftpget, ftpput, fuser, getopt, getty, grep, gunzip, gzip, hd,
hdparm, head, hexdump, hostid, hostname, httpd, hush, hwclock, id,
ifconfig, ifdown, ifenslave, ifplugd, ifup, inetd, init, inotifyd,
insmod, install, ionice, ip, ipaddr, ipcalc, ipcrm, ipcs, iplink,
iproute, iprule, iptunnel, kbd_mode, kill, killall, killall5, klogd,
last, length, less, linux32, linux64, linuxrc, ln, loadfont,
loadkmap, logger, login, logname, logread, losetup, lpd, lpq, lpr,
ls, lsattr, lsmod, lzmacat, lzop, lzopcat, makemime, man, md5sum,
mdev, mesg, microcom, mkdir, mkdosfs, mkfifo, mkfs.minix, mkfs.vfat,
mknod, mkpasswd, mkswap, mktemp, modprobe, more, mount, mountpoint,
mt, mv, nameif, nc, netstat, nice, nmeter, nohup, nslookup, od,
openvt, passwd, patch, pgrep, pidof, ping, ping6, pipe_progress,
pivot_root, pkill, popmaildir, printenv, printf, ps, pscan, pwd,
raidautorun, rdate, rdev, readlink, readprofile, realpath,
reformime, renice, reset, resize, rm, rmdir, rmmod, route, rpm,
rpm2cpio, rtcwake, run-parts, runlevel, runsv, runsvdir, rx, script,
scriptreplay, sed, sendmail, seq, setarch, setconsole, setfont,
setkeycodes, setlogcons, setsid, setuidgid, sh, sha1sum, sha256sum,
sha512sum, showkey, slattach, sleep, softlimit, sort, split,
start-stop-daemon, stat, strings, stty, su, sulogin, sum, sv,
svlogd, swapoff, swapon, switch_root, sync, sysctl, syslogd, tac,
tail, tar, taskset, tcpsvd, tee, telnet, telnetd, test, tftp, tftpd,
time, timeout, top, touch, tr, traceroute, true, tty, ttysize,
udhcpc, udhcpd, udpsvd, umount, uname, uncompress, unexpand, uniq,
unix2dos, unlzma, unlzop, unzip, uptime, usleep, uudecode, uuencode,
vconfig, vi, vlock, volname, watch, watchdog, wc, wget, which, who,
whoami, xargs, yes, zcat, zcip
EOF

sed -e 's/, /\n/g' -e 's/,$//g' /tmp/get-bb-busyboxapplets > /tmp/get-bb-busyboxapplets-2

diff --side-by-side /tmp/get-bb-busyboxapplets-2 /tmp/get-bb-words-2 | grep -v '[|<>]' | awk '{print$1}'
rm -r /tmp/get-bb* 2>/dev/null