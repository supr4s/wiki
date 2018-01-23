### PuTTY configuration

**Connection** => **Data** => replace value xterm by **xterm-color** and don't forget save session parameters

### /etc/bash.bashrc

```
case "$TERM" in
 xterm-color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

