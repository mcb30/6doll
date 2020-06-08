Technical details
=================

How it works
------------

The N300 is running a build of [OpenWrt][openwrt] preconfigured to use
[Teredo tunneling][teredo] to obtain a globally routable IPv6 address
via your normal home Internet connection using a Teredo relay.

The N300 then advertises itself as an IPv6 router, providing access to
the IPv6 Internet for any other devices on the same network.  Devices
will be allocated an IPv6 [unique local address][ula], which is
roughly equivalent to an [IPv4 private address][rfc1918].  Outbound
IPv6 traffic is masqueraded to appear from the Teredo address.

Building
--------

The firmware image is built using the [OpenWrt][openwrt] image
builder.  You can rebuild the image by cloning this repository and
running

```shell
make
```

Alternatively, you can download a prebuilt version of the [latest
firmware image][sysimage].

Installing
----------

1. Disconnect the micro USB power cable from your N300.
2. Use a pin to press and hold the reset switch (next to the micro USB
   socket).
3. With the reset switch still pressed, reconnect the power cable to
   your N300.
4. Wait until the LED has blinked five times.
5. Release the reset switch.
6. Configure your workstation with an additional IP address
   `192.168.1.2/24`.
7. Upload the new [firmware image][sysimage] to your N300 via the web
   page at `http://192.168.1.1`.

Troubleshooting
---------------

1. Configure your workstation with an additional IP address
   `192.168.8.2/24`.  (Note that this is different from the address
   used above for installing a new firmware image.)
2. Log in to the [OpenWrt](openwrt) control panel for your N300 at
   `http://192.168.8.1` using the user name `root`.  The initial
   password is set to the device serial number (`S/N`), which you can
   find printed on the case label.


[sysimage]: https://github.com/unipartdigital/6doll/releases/latest/download/openwrt-ramips-mt76x8-glinet_microuter-n300-squashfs-sysupgrade.bin
[openwrt]: https://openwrt.org/
[teredo]: https://en.wikipedia.org/wiki/Teredo_tunneling
[ula]: https://en.wikipedia.org/wiki/Unique_local_address
[rfc1918]: https://tools.ietf.org/html/rfc1918
