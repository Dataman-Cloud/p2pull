# p2pull
Peer-to-peer push/pull between docker hosts on beijing #dockerhackday


# Member
* Xiao Deshi
* Yao Yun
* Zhang Mingfeng

## How to make it work

This was only tested with self-hosted docker registry.
Docker hub works a little bit differently than self-hosted
registry to make it work with p2p easily.

Let's run tracker on `192.168.0.1` (`host1`) and proxies on `192.168.0.{2,3,4}` (`host{2,3,4}`).

```
host1> docker run -d --net=host bobrik/bay-tracker \
  -listen 192.168.0.1:8888 -tracker 192.168.0.4:6881 -root /tmp
```

Now let's run local proxies on each box:

```
host2> docker run -d -p 127.0.0.1:80:80 bobrik/bay-proxy \
  -tracker http://192.168.0.1:8888/ -listen :80 -root /tmp

host3> docker run -d -p 127.0.0.1:80:80 bobrik/bay-proxy \
  -tracker http://192.168.0.1:8888/ -listen :80 -root /tmp

host4> docker run -d -p 127.0.0.1:80:80 bobrik/bay-proxy \
  -tracker http://192.168.0.1:8888/ -listen :80 -root /tmp
```

In `/etc/hosts` on each machine add the next record:

```
127.0.0.1 p2p-<my-registry.com>
```

where `my-registry.com` should be your usual registry.

After that on `host{2,3,4}` you can run:


```
docker pull p2p-<my-registry.com>/myimage
```

and it will work just like

```
docker pull <my-registry.com>/myimage
```

but with p2p magic and unicorns.
