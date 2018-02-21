# Federation Tests

This repository is about automating federation unit tests.

If you want to use travis, this could look like following:

```
sudo: required
services:
- docker
- postgresql

[...]

install:
- docker run --name=d1 -e DATABASE=d1 -e PORT=3000 -p 3000:3000 --net=host -d thefederation/testing_diaspora:latest
script:
- curl http://localhost:3000/hcard/users/2d4fa7e0e5380135fa593c970e8692d1
```

## Projects

For reference implementation you can checkout following projects:

* [github.com/ganggo/ganggo](https://github.com/ganggo/ganggo)
