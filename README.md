# Install

to install this thing you need quickshell installed (ofc). if you dont have it installed it wont stinkin' work.
(just install it in any way you want, preferably with the package manager of your distro)

once you are sure that quickshell is installed, you can clone this repo into your `.config` of your user.

```bash
mkdir -p ~/.config
cd  ~/.config
git clone https://github.com/Nissemanen/my-ass-quickshell.git ~/.config/quickshell
```

if you think you are smart and that you dont need the code above, just remember that you are not alone and that im just like you, but more importantly remember that quickshell wont use this config unless its like actually inside `~/.config/quickshell`, so like dont have a `~/.config/my-ass-quickshell` direftory wondering why it wont work. if you want it to be in a specific folder except the default, you will have to consult the quickshell docs, cause i aint writing a single scentence to describe that (you run `qs -c {path_to_config}` and it'll use that dir as the config).

now dont expect a functioning thing, if you want it to be better youll just have to read through my spaghetti of so called code and implement your idea yourself.
