# meta-flutter-vm

## Virutal Machine Layer

Collection of Virtual Machine recipes

### crosvm

Builds binary `crosvm`

### crosvm-direct

Builds binary `crosvm-direct`

### crosvm-plugin

Builds shared module `libcrosvm_plugin.so`

### sommelier

Builds binary sommelier

- Note: unfortunately `x11` is required

### firecracker

Requires the following flags in your local.conf

```
TCLIBC = "musl"
RUST_PANIC_STRATEGY = "abort"
```

Basic functional test passes:
```
cd ~
/usr/share/firecracker/hello-firecracker.sh
```

### jailer

Requires the following flag in your local.conf

```
RUST_PANIC_STRATEGY = "abort"
```

Basic functional test is failing:
```
$ rm -rf /tmp/firecracker.socket
$ jailer --id 1234 --exec-file /usr/bin/firecracker --uid $UID --gid $UID -- --api-sock /tmp/firecracker.socket --config-file /usr/share/firecracker/hello-conf.json
thread 'main' panicked at 'Jailer error: Failed to create /dev/net/tun via mknod inside the jail: File exists (os error 17)', src/jailer/src/main.rs:431:27
```
Seems it's expecting to own /dev/net/tun, and whatever driver is creating this needs to be disabled.

### seccompiler-native

Requires the following flag in your local.conf

```
RUST_PANIC_STRATEGY = "abort"
```

Used by firecracker target build pass.
